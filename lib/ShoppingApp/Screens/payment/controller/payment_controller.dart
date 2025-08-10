import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({required int amount}) {
    var options = {
      'key': 'rzp_test_YourKeyHere', // Replace with your Razorpay key
      'amount': amount * 100, // In paise
      'name': 'JTPL Cricket Store',
      'description': 'Product Payment',
      'prefill': {
        'contact': '9876543210',
        'email': 'test@example.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Payment Successful", "Payment ID: ${response.paymentId}",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "${response.message}",
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet Selected", "${response.walletName}",
        backgroundColor: Colors.blue, colorText: Colors.white);
  }

  @override
  void onClose() {
    _razorpay.clear(); // release resources
    super.onClose();
  }
}
