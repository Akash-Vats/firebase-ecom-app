import 'package:chat_app/ShoppingApp/Models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllCategoriesWidget extends StatelessWidget {
  const AllCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
      AppBar(title: const Text("All Category"),),
  body: FutureBuilder(
    future: FirebaseFirestore.instance.collection("categories").get(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Error"),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("No Category"),
        );
      }
      if (snapshot.data != null) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.8,
            mainAxisSpacing: 0.1,
            childAspectRatio: 1, 
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            CategoriesModel categoryModel = CategoriesModel(
              categoryId: snapshot.data!.docs[index]["categoryId"],
              categoryImg: snapshot.data!.docs[index]["imgUrl"],
              categoryName: snapshot.data!.docs[index]["categoryName"],
              createdAt: snapshot.data!.docs[index]["createdAt"],
              updatedAt: snapshot.data!.docs[index]["updatedAt"],
            );

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: categoryModel.categoryImg,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categoryModel.categoryName,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        );
      }
      return const SizedBox();
    },
  ),
    );
  }
}
