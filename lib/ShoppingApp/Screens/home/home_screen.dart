import 'package:chat_app/ShoppingApp/Widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Common/app_colors.dart';
import '../../Widgets/categories_widget.dart';
import '../../Widgets/drawer_widget.dart';
import '../../Widgets/heading_widget.dart';
import '../../Widgets/highly_recommand.dart';
import '../../Widgets/topmost_widget.dart';
import '../AllCategoryScreen/all_category_screen.dart';
import '../AllProducts/all_products_screen.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary,
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      drawer:DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
          SizedBox(height: 20.h,),
          BannerWidget(),
            HeadingWidget(headingTitle: 'Categories', headingSubtitle: 'Low Budget', buttonText: 'See more >', onTap: () {
              Get.to(const AllCategoriesWidget());
            },),
            SizedBox(height: 10.h,),
            const CategoriesWidget() ,
            SizedBox(height: 10.h,),
            HeadingWidget(headingTitle: 'Topmost', headingSubtitle: 'High Budget', buttonText: 'See more >', onTap: () {
              Get.to(AllProductsScreen());
            },),
            SizedBox(height: 10.h,),
            const TopMostWidget(),
            SizedBox(height: 20.h,),
            HeadingWidget(headingTitle: 'All Products', headingSubtitle: 'Highly Recommended', buttonText: 'See more >', onTap: () {
              Get.to(AllProductsScreen());
            },),
            SizedBox(height: 10.h,),
            HighlyRecommandWidget()
                ],),
        ),),
    );
  }
}
