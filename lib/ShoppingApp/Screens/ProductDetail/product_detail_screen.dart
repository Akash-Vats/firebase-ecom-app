import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/ShoppingApp/AppRoutes/app_routes.dart';
import 'package:chat_app/ShoppingApp/Common/app_colors.dart';
import 'package:chat_app/ShoppingApp/Models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ShoppingApp/Models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      viewportFraction: 1.0,
                    ),
                    items: product.productImages.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.categoryName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\Rs- ${product.salesPrice}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\Rs- ${product.fullPrice}',
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productDescription,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // WhatsApp + Add to Cart Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // WhatsApp action
                    },
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: const Text("WhatsApp"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      await checkProductExistence(uid: FirebaseAuth.instance.currentUser!.uid);
                    },
                    icon: const Icon(Icons.add_shopping_cart,
                        color: Colors.white),
                    label: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Buy Now Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Buy Now action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Buy Now',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> checkProductExistence(
      {required String uid, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .collection("cartOrders")
        .doc(product.productId.toString());
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      int currentQuantity = documentSnapshot["productQuantity"];
      int updateQuantity= currentQuantity+quantityIncrement;
      double totalPrice=double.parse(product.isSale?product.salesPrice:product.fullPrice)*updateQuantity;
      await documentReference.update(
          {'productQuantity':updateQuantity,
            'productTotalPrice':totalPrice
      });
    } else {
await FirebaseFirestore.instance.collection('cart').doc(uid).set({
  "uId":uid,
  "createdAt":DateTime.now()
});
CartModel cartModel=CartModel(productId: product.productId,
    categoryId: product.categoryId, productName: product.categoryName,
    categoryName: product.categoryName,
    salePrice: product.salesPrice,
    fullPrice: product.fullPrice,
    productImages: product.productImages,
    deliveryTimes: product.deliveryTime,
    isSale: product.isSale, productDescription:
    product.productDescription, createdAt:DateTime.now(), updatedAt: DateTime.now(),
    productQuantity: 1, productTotalPrice: double.parse(product.fullPrice));
await documentReference.set(cartModel.toJson());
    }
  }
}
