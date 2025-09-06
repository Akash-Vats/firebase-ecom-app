// controller/checkout_controller.dart

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Models/cart_model.dart';
import '../../cartscreen/controller/cart_controller.dart';

class CheckoutController extends GetxController {
  final RxBool isPlacingOrder = false.obs;
  final List<CartModel> cartItems;
  late Razorpay _razorpay;

  String userName = '';
  String phoneNumber = '';
  String address = '';

  CheckoutController(this.cartItems);

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.productTotalPrice);
  
  double get subtotalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.productTotalPrice);

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void confirmOrder({
    required String userName,
    required String phoneNumber,
    required String address,
  }) {
    this.userName = userName;
    this.phoneNumber = phoneNumber;
    this.address = address;

    isPlacingOrder.value = true;

    var options = {
      'key': 'rzp_test_SY4HPR3Oa0CJ66', // Replace with real Razorpay key
      'amount': (totalPrice * 100).toInt(), // In paise
      'name': 'JTPL Cricket',
      'description': 'Product Purchase',
      'prefill': {
        'contact': phoneNumber,
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      isPlacingOrder.value = false;
      Get.snackbar("Error", "Failed to open Razorpay: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final orderRef = FirebaseFirestore.instance
        .collection('orders')
        .doc(userId)
        .collection('userOrders')
        .doc();

    final orderId = orderRef.id;

    List<Map<String, dynamic>> products =
    cartItems.map((item) => item.toJson()).toList();

    await orderRef.set({
      'orderId': orderId,
      'userId': userId,
      'products': products,
      'totalAmount': totalPrice,
      'status': 'Paid',
      'paymentId': response.paymentId,
      'orderedAt': DateTime.now(),
      'customerName': userName,
      'customerPhone': phoneNumber,
      'deliveryAddress': address,
    });

    final CartController cartController = Get.put(CartController());
    await cartController.clearCart();

    isPlacingOrder.value = false;

    Get.snackbar("Success", "Payment Successful & Order Placed!",
        backgroundColor: Colors.green, colorText: Colors.white);

    Get.back(); // Optionally navigate to home/orders screen
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    isPlacingOrder.value = false;

    Get.snackbar("Payment Failed", response.message ?? "Unknown error",
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "${response.walletName}",
        backgroundColor: Colors.blue, colorText: Colors.white);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
