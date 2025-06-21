// highly_recommand_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../Models/category_model.dart';
import '../../../Models/product_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<ProductModel> recommendedProducts = <ProductModel>[].obs;
  RxBool isCategoryLoading = true.obs;
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    fetchRecommendedProducts();
    fetchCategories();

    super.onInit();
  }







  void fetchCategories() async {
    try {
      isCategoryLoading.value = true;
      final querySnapshot = await FirebaseFirestore.instance.collection("categories").get();

      categories.value = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CategoriesModel(
          categoryId: data["categoryId"],
          categoryImg: data["imgUrl"],
          categoryName: data["categoryName"],
          createdAt: data["createdAt"],
          updatedAt: data["updatedAt"],
        );
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories");
    } finally {
      isCategoryLoading.value = false;
    }
  }

  void fetchRecommendedProducts() async {
    try {
      final query = await FirebaseFirestore.instance
          .collection("products")
          .where("isSale", isEqualTo: true)
          .get();

      recommendedProducts.value = query.docs.map((doc) {
        final data = doc.data();
        return ProductModel(
          categoryId: data["categoryId"],
          categoryName: data["categoryName"],
          createdAt: data["createdAt"],
          updatedAt: data["updatedAt"],
          deliveryTime: data["deliveryTime"],
          isSale: data["isSale"],
          productImages: List<String>.from(data["productImages"]),
          salesPrice: data["salesPrice"],
          fullPrice: data["fullPrice"],
          productId: data["productId"],
          productDescription: data["productDescription"],
        );
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products");
    } finally {
      isLoading.value = false;
    }
  }
}
