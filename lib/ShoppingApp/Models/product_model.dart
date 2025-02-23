import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {

  final String categoryId;
  final String categoryName;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String deliveryTime;
  final bool isSale;
  final List<dynamic> productImages;
  final String salesPrice;
  final String fullPrice;
  final String productId;
  final String productDescription;

  ProductModel({
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryTime,
    required this.isSale,
    required this.productImages,
    required this.salesPrice,
    required this.fullPrice,
    required this.productId,
    required this.productDescription,
  });


  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      deliveryTime: map['deliveryTime'] ?? '',
      isSale: map['isSale'] ?? false,
      productImages: List<String>.from(map['productImages'] ?? []),
      salesPrice: map['salesPrice']?.toDouble() ?? 0.0,
      fullPrice: map['fullPrice']?.toDouble() ?? 0.0,
      productId: map['productId'] ?? '',
      productDescription: map['productDescription'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deliveryTime': deliveryTime,
      'isSale': isSale,
      'productImages': productImages,
      'salesPrice': salesPrice,
      'fullPrice': fullPrice,
      'productId': productId,
      'productDescription': productDescription,
    };
  }
}
