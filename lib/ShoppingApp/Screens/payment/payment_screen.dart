import 'package:chat_app/ShoppingApp/Common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/cart_model.dart';
import '../checkout_screen/controller/checkout_controller.dart';

class PaymentScreen extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String address;
  final List<CartModel> cartItems;

  const PaymentScreen({
    super.key,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController(cartItems));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor:AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Review & Pay",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildSectionTitle("Shipping Details"),
            _buildDetailCard([
              "Name: $userName",
              "Phone: $phoneNumber",
              "Address: $address",
            ]),

            const SizedBox(height: 20),
            _buildSectionTitle("Order Summary"),
            _buildDetailCard([
              "Items: ${cartItems.length}",
              "Total Amount: ₹${controller.totalPrice.toStringAsFixed(2)}"
            ]),

            const SizedBox(height: 40),

            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isPlacingOrder.value
                    ? null
                    : () async {
                    controller.confirmOrder(
                    userName: userName,
                    phoneNumber: phoneNumber,
                    address: address,
                  );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isPlacingOrder.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Pay Now",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style:
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  Widget _buildDetailCard(List<String> lines) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map((line) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            line,
            style: const TextStyle(fontSize: 16),
          ),
        ))
            .toList(),
      ),
    );
  }
}
