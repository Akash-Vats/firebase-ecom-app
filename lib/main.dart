

import 'package:chat_app/Screens/complete_profile_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'NewchatApp/views/chat_screen.dart';
import 'NewchatApp/views/login_screen.dart';
import 'NewchatApp/views/register_screen.dart';
import 'Services/notification_services.dart';
import 'ShoppingApp/AppRoutes/app_pages.dart';
import 'ShoppingApp/AppRoutes/app_routes.dart';
import 'ShoppingApp/Models/product_model.dart';
import 'ShoppingApp/Services/product_servies.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());


 /* ProductService productService = ProductService();


  List<ProductModel> products = [
    ProductModel(
      categoryId: "1",
      categoryName: "Jacket",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "2-3 days",
      isSale: true,
      productImages: ["https://m.media-amazon.com/images/I/71SAytD3C+L._SY879_.jpg","https://averyscove.com/cdn/shop/files/S28459f8315f848f4aeaa1f7e77927367n.webp?v=1726499592&width=1080"],
      salesPrice: "499",
      fullPrice: "599",
      productId: "P001",
      productDescription: "High-quality electronic device",
    ),
    ProductModel(
      categoryId: "2",
      categoryName: "Mens jeans",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "3-5 days",
      isSale: true,
      productImages: ["https://www.beyoung.in/api/cache/catalog/products/men_new_jeans/indigo_blue_baggy_fit_jeans_base_08_03_2024_700x933.jpg","https://rickrogue.com/cdn/shop/files/5U2A9873_6883bbbf-9d93-4ec8-bb2c-e50b2cac66ac.jpg?v=1732260179"],
      salesPrice: "999",
      fullPrice: "1299",
      productId: "P002",
      productDescription: "Comfortable cotton t-shirt",
    ),
    ProductModel(
      categoryId: "3",
      categoryName: "Pants",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "1-2 days",
      isSale: true,
      productImages: ["https://www.beyoung.in/api/cache/catalog/products/men_new_jeans/indigo_blue_baggy_fit_jeans_full_view_06_02_2024_700x933.jpg"],
      salesPrice: "199",
      fullPrice: "299",
      productId: "P003",
      productDescription: "Bestselling novel",
    ),
    ProductModel(
      categoryId: "4",
      categoryName: "Clothes",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "4-6 days",
      isSale: true,
      productImages: ["https://naava.co.in/cdn/shop/files/preview_images/b2c6d624d5d14d93a6fc3e63be19cfcb.thumbnail.0000000000.jpg?v=1735896542&width=3000"],
      salesPrice: "1999",
      fullPrice: "2499",
      productId: "P004",
      productDescription: "Powerful vacuum cleaner",
    ),
    ProductModel(
      categoryId: "5",
      categoryName: "Girls Shoes",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "2-3 days",
      isSale: true,
      productImages: ["https://assets.myntassets.com/w_412,q_60,dpr_2,fl_progressive/assets/images/22041064/2023/2/18/10700a6d-74a7-4e8b-afab-585f09869b6e1676726159705ShoetopiaGirlsPinkColourblockedSkateShoes1.jpg","https://5.imimg.com/data5/ANDROID/Default/2022/2/QB/CV/LU/73718625/product-jpeg-500x500.jpg"],
      salesPrice: "2999",
      fullPrice: "3499",
      productId: "P005",
      productDescription: "Durable yoga mat",
    ),
    ProductModel(
      categoryId: "6",
      categoryName: "Beauty",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "2-3 days",
      isSale: true,
      productImages: ["https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRdlPFyNqjP9K85G4UWrJAIhMEfZuBXW8vTDmKPuE587olSHxNnKIzNPn_aU4Snq50u34b6kI58Mna4VF0G88aiS7H-jIGdFXEazW0WB3Fxoz0ZygdMywS5KV19fjLsA8kOn0yV2xpeWQ&usqp=CAc"],
      salesPrice: "699",
      fullPrice: "899",
      productId: "P006",
      productDescription: "Organic skincare set",
    ),
    ProductModel(
      categoryId: "7",
      categoryName: "Tops",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "5-7 days",
      isSale: true,
      productImages: ["https://littleboxindia.com/cdn/shop/products/c7088e1a4553af0347d7753cd18ba82f_900x.jpg?v=1684142845"],
      salesPrice: "3999",
      fullPrice: "4999",
      productId: "P007",
      productDescription: "Professional football kit",
    ),
    ProductModel(
      categoryId: "8",
      categoryName: "Toys",
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
      deliveryTime: "2-4 days",
      isSale: true,
      productImages: ["https://www.funcorp.in/cdn/shop/products/giggles_fire_engine_1.jpg?v=1675926067"],
      salesPrice: "999",
      fullPrice: "1199",
      productId: "P008",
      productDescription: "Educational toy for kids",
    ),

  ];


  await productService.addProducts(products);*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}


