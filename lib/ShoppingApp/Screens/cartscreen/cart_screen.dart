import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../checkout_screen/checkout_screen.dart';
import 'controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
              child: Text("Your cart is empty",
                  style: TextStyle(fontSize: 18, color: Colors.grey)));
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            itemCount: controller.cartItems.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];

              return Dismissible(
                key: Key(item.productId),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => controller.deleteItem(item),
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  color: Colors.red.shade400,
                  child: const Icon(Icons.delete, color: Colors.white, size: 28),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.productImages.first,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Item info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.productName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  _qtyButton(
                                      icon: Icons.remove_circle_outline,
                                      onTap: () => controller.updateQuantity(
                                          item, item.productQuantity - 1)),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text('${item.productQuantity}',
                                        style: const TextStyle(fontSize: 16)),
                                  ),
                                  _qtyButton(
                                      icon: Icons.add_circle_outline,
                                      onTap: () => controller.updateQuantity(
                                          item, item.productQuantity + 1)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Price
                        Text(
                          '₹${item.productTotalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) return const SizedBox();

        return Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Total:\n',
                  style: const TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: '₹${controller.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => CheckoutScreen(
                    cartItems: controller.cartItems,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, size: 22, color: Colors.deepPurple),
    );
  }
}
