import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Models/cart_model.dart';

class CartController extends GetxController {
  final RxList<CartModel> cartItems = <CartModel>[].obs;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  double get totalPrice =>
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
    await firestore
        .collection('cart')
        .doc(uid)
        .collection('cartOrders')
        .doc(item.productId)
        .delete();

    Get.snackbar('Removed', '${item.productName} removed from cart');
  }

  Future<void> clearCart() async {
    final cartRef = firestore
        .collection('cart')
        .doc(uid)
        .collection('cartOrders');

    final snapshot = await cartRef.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
