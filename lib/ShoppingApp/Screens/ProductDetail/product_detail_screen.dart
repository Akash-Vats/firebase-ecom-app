import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/ShoppingApp/Common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ShoppingApp/Models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary,
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
    crossAxisAlignment:CrossAxisAlignment.start,children: [

    const SizedBox(height: 16),

    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.categoryName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(children: [
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
            style:  const TextStyle(decoration: TextDecoration.lineThrough,
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],)
      ],
    ),

    const SizedBox(height: 8),
    Text(
      product.productDescription,
      style: const TextStyle(fontSize: 16, height: 1.5),
    ),
  ],),
)


          ],
        ),
      ),
      bottomNavigationBar: Container(

        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Buy Now',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),
    );
  }
}
