import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/ShoppingApp/AppRoutes/app_routes.dart';
import 'package:chat_app/ShoppingApp/Common/app_colors.dart';
import 'package:chat_app/ShoppingApp/Models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/ShoppingApp/Models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isAddingToCart = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Image
          SliverAppBar(
            expandedHeight: 400.h,
            pinned: true,
            backgroundColor: AppColors.surface,
            leading: Container(
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20.sp),
                onPressed: () => Get.back(),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.favorite_border, color: AppColors.textPrimary, size: 20.sp),
                  onPressed: () {
                    Get.snackbar(
                      'Added to Favorites',
                      '${widget.product.categoryName} added to favorites',
                      backgroundColor: AppColors.success,
                      colorText: Colors.white,
                    );
                  },
                ),
              ),
              SizedBox(width: 8.w),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Image Carousel
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400.h,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: widget.product.productImages.map((imageUrl) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black26],
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.backgroundGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.backgroundGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Icon(
                              Icons.image_outlined,
                              size: 60.sp,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  // Image Indicators
                  Positioned(
                    bottom: 20.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.product.productImages.asMap().entries.map((entry) {
                        return Container(
                          width: _currentImageIndex == entry.key ? 24.w : 8.w,
                          height: 8.h,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: _currentImageIndex == entry.key 
                                ? AppColors.primary 
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Product Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title and Price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.categoryName,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    widget.product.categoryName,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (widget.product.isSale) ...[
                                  Text(
                                    '₹${widget.product.fullPrice}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.textTertiary,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                ],
                                Text(
                                  '₹${widget.product.salesPrice}',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (widget.product.isSale) ...[
                                  SizedBox(height: 4.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      'Save ₹${(double.parse(widget.product.fullPrice) - double.parse(widget.product.salesPrice)).toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Rating and Reviews
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: AppColors.warning, size: 16.sp),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '(128 reviews)',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Quantity Selector
                        Row(
                          children: [
                            Text(
                              'Quantity:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildQuantityButton(
                                    icon: Icons.remove,
                                    onTap: _quantity > 1 ? () {
                                      setState(() {
                                        _quantity--;
                                      });
                                    } : null,
                                  ),
                                  Container(
                                    width: 50.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$_quantity',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  _buildQuantityButton(
                                    icon: Icons.add,
                                    onTap: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Product Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          widget.product.productDescription,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textSecondary,
                            height: 1.6,
                            letterSpacing: 0.3,
                          ),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Features
                        _buildFeatureSection(),
                        
                        SizedBox(height: 24.h),
                        
                        // Delivery Info
                        _buildDeliveryInfo(),
                        
                        SizedBox(height: 100.h), // Space for bottom buttons
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Action Buttons
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Add to Cart Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isAddingToCart ? null : _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: _isAddingToCart
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              
              SizedBox(width: 12.w),
              
              // Buy Now Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.success.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _buyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on, color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: isEnabled 
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.textTertiary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isEnabled ? AppColors.primary : AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildFeatureSection() {
    final features = [
      {'icon': Icons.local_shipping, 'title': 'Free Delivery', 'subtitle': 'On orders over ₹500'},
      {'icon': Icons.undo, 'title': 'Easy Returns', 'subtitle': '30 days return policy'},
      {'icon': Icons.security, 'title': 'Secure Payment', 'subtitle': '100% secure checkout'},
      {'icon': Icons.support_agent, 'title': '24/7 Support', 'subtitle': 'Always here to help'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        ...features.map((feature) => Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      feature['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_shipping, color: AppColors.info, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Information',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.info,
                  ),
                ),
                Text(
                  'Estimated delivery: ${widget.product.deliveryTime}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart() async {
    setState(() {
      _isAddingToCart = true;
    });

    try {
      await checkProductExistence(uid: FirebaseAuth.instance.currentUser!.uid, quantityIncrement: _quantity);
      Get.snackbar(
        'Added to Cart',
        '${widget.product.categoryName} added to cart successfully!',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add item to cart. Please try again.',
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _isAddingToCart = false;
      });
    }
  }

  void _buyNow() {
    // Navigate to checkout with this product
    Get.snackbar(
      'Buy Now',
      'Redirecting to checkout...',
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
    // TODO: Implement buy now functionality
  }

  Future<void> checkProductExistence({required String uid, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .collection("cartOrders")
        .doc(widget.product.productId.toString());
    
    DocumentSnapshot documentSnapshot = await documentReference.get();
    
    if (documentSnapshot.exists) {
      int currentQuantity = documentSnapshot["productQuantity"];
      int updateQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.product.isSale ? widget.product.salesPrice : widget.product.fullPrice) * updateQuantity;
      
      await documentReference.update({
        'productQuantity': updateQuantity,
        'productTotalPrice': totalPrice,
        'updatedAt': DateTime.now(),
      });
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uid).set({
        "uId": uid,
        "createdAt": DateTime.now()
      });
      
      CartModel cartModel = CartModel(
        productId: widget.product.productId,
        categoryId: widget.product.categoryId,
        productName: widget.product.categoryName,
        categoryName: widget.product.categoryName,
        salePrice: widget.product.salesPrice,
        fullPrice: widget.product.fullPrice,
        productImages: widget.product.productImages,
        deliveryTimes: widget.product.deliveryTime,
        isSale: widget.product.isSale,
        productDescription: widget.product.productDescription,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        productQuantity: quantityIncrement,
        productTotalPrice: double.parse(widget.product.isSale ? widget.product.salesPrice : widget.product.fullPrice) * quantityIncrement,
      );
      
      await documentReference.set(cartModel.toJson());
    }
  }
}