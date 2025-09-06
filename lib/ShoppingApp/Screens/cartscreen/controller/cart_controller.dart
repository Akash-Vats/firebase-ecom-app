import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Common/app_colors.dart';
import '../../../Models/cart_model.dart';

class CartController extends GetxController {
  final RxList<CartModel> cartItems = <CartModel>[].obs;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.productTotalPrice);
  
  double get subtotalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.productTotalPrice);

  @override
  void onInit() {
    super.onInit();
    _listenToCartChanges(); // real-time listener
  }

  void _listenToCartChanges() {
    firestore
        .collection('cart')
        .doc(uid)
        .collection('cartOrders')
        .snapshots()
        .listen((snapshot) {
      cartItems.value =
          snapshot.docs.map((doc) => CartModel.fromJson(doc.data())).toList();
    });
  }

  Future<void> updateQuantity(CartModel item, int newQuantity) async {
    if (newQuantity < 1) return;

    final price = double.parse(item.isSale ? item.salePrice : item.fullPrice);
    final newTotal = price * newQuantity;

    await firestore
        .collection('cart')
        .doc(uid)
        .collection('cartOrders')
        .doc(item.productId)
        .update({
      'productQuantity': newQuantity,
      'productTotalPrice': newTotal,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> deleteItem(CartModel item) async {
    try {
      await firestore
          .collection('cart')
          .doc(uid)
          .collection('cartOrders')
          .doc(item.productId)
          .delete();

      Get.snackbar(
        'Item Removed',
        '${item.productName} has been removed from your cart',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item from cart. Please try again.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> clearCart() async {
    try {
      final cartRef = firestore
          .collection('cart')
          .doc(uid)
          .collection('cartOrders');

      final snapshot = await cartRef.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
      
      Get.snackbar(
        'Cart Cleared',
        'All items have been removed from your cart',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear cart. Please try again.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
