// controller/checkout_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Models/cart_model.dart';
import '../../cartscreen/controller/cart_controller.dart';

class CheckoutController extends GetxController {
  final RxBool isPlacingOrder = false.obs;
  final List<CartModel> cartItems;

  CheckoutController(this.cartItems);

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.productTotalPrice);

  Future<void> confirmOrder({
    required String userName,
    required String phoneNumber,
    required String address,
  }) async {
    isPlacingOrder.value = true;

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
      'status': 'Pending',
      'orderedAt': DateTime.now(),
      'customerName': userName,
      'customerPhone': phoneNumber,
      'deliveryAddress': address,
    });

    // Clear cart
    final CartController cartController = Get.find();
    await cartController.clearCart();

    isPlacingOrder.value = false;

    Get.snackbar("Success", "Order placed successfully!");
    Get.back(); // Close checkout screen
  }
}
