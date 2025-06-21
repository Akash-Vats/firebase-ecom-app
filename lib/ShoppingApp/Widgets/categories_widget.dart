import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/ShoppingApp/Screens/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCategoryLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      }

      if (controller.categories.isEmpty) {
        return const Center(child: Text("No Category"));
      }

      return SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: category.categoryImg,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category.categoryName,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
