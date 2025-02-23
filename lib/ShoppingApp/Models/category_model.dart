import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      categoryId: map['categoryId'] ?? '',
      categoryImg: map['categoryImg'] ?? '',
      categoryName: map['categoryName'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
