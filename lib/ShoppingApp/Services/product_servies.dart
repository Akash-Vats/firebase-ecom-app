import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/product_model.dart';


class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProducts(List<ProductModel> products) async {
    try {
      final productCollection = _firestore.collection('products');

      for (var product in products) {
        await productCollection.add(product.toMap());
      }
      print("10 products added successfully!");
    } catch (e) {
      print("Error adding products: $e");
    }
  }
}


