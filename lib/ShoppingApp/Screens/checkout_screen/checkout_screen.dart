import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/cart_model.dart';
import '../payment/payment_screen.dart';
import 'controller/checkout_controller.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartModel> cartItems;
  const CheckoutScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.put(CheckoutController(cartItems));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order Summary",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.productImages.first,
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item.productName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("Qty: ${item.productQuantity}"),
                      trailing: Text(
                        "₹${item.productTotalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Obx(() => Text(
                      "₹${controller.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isPlacingOrder.value
                    ? null
                    : () => _showAddressBottomSheet(controller),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: controller.isPlacingOrder.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void _showAddressBottomSheet(CheckoutController controller) {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(Icons.drag_handle, size: 30, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text("Delivery Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildInputField("Full Name", nameController),
              const SizedBox(height: 12),
              _buildInputField("Phone Number", phoneController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              _buildInputField("Delivery Address", addressController,
                  maxLines: 3),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isPlacingOrder.value
                      ? null
                      : () {
                    final name = nameController.text.trim();
                    final phone = phoneController.text.trim();
                    final address = addressController.text.trim();

                    if (name.isEmpty ||
                        phone.isEmpty ||
                        address.isEmpty) {
                      Get.snackbar("Missing Info",
                          "Please fill in all fields to proceed.");
                      return;
                    }

                    Get.back(); // Close bottom sheet

                    Get.to(() => PaymentScreen(
                      userName: name,
                      phoneNumber: phone,
                      address: address,
                      cartItems: controller.cartItems,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: controller.isPlacingOrder.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Continue to Payment",
                      style:
                      TextStyle(fontSize: 16, color: Colors.white)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
