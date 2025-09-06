import 'package:chat_app/ShoppingApp/Widgets/banner_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import '../cartscreen/cart_screen.dart';
import '../cartscreen/controller/cart_controller.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom App Bar
        Container(
          color: AppColors.surface,
          child: SafeArea(
            child: Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  // Menu Button
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.border,
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.menu,
                        color: AppColors.textPrimary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Logo and Title
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Find your perfect items',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Cart Button
                  Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: Stack(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                            onPressed: () {
                              Get.to(() => CartScreen());
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Obx(() {
                          final cartController = Get.put(CartController());
                          final itemCount = cartController.cartItems.length;
                          if (itemCount == 0) return const SizedBox.shrink();
                          
                          return Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 14.w,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(7.r),
                              ),
                              child: Center(
                                child: Text(
                                  itemCount > 99 ? '99+' : itemCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Body Content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                
                // Banner Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: BannerWidget(),
                ),
                
                SizedBox(height: 24.h),
                
                // Categories Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllCategoriesWidget());
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CategoriesWidget(),
                ),
                
                SizedBox(height: 24.h),
                
                // Top Most Products Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Most',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllProductsScreen());
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TopMostWidget(),
                ),
                
                SizedBox(height: 24.h),
                
                // Highly Recommended Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Highly Recommended',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AllProductsScreen());
                        },
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: HighlyRecommandWidget(),
                ),
                
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}