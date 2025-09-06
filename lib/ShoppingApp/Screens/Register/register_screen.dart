import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../AppRoutes/app_routes.dart';
import '../../Common/app_colors.dart';
import 'controller/sign_up_controllre.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with TickerProviderStateMixin {
  final SignUpController controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 40.h),
                      
                      // Logo and Welcome Section
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: AppColors.primaryGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_add_outlined,
                                size: 50.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Join us and start your shopping journey",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 32.h),
                      
                      // Registration Form
                      Container(
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name Field
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter your full name";
                                  } else if (value.trim().length < 2) {
                                    return "Name must be at least 2 characters";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primary,
                                controller: controller.userNameController,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  hintText: "Enter your full name",
                                  hintStyle: TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.error,
                                      width: 2.w,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.textTertiary,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 20.h),
                              
                              // Email Field
                              Text(
                                "Email Address",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter your email";
                                  } else if (!GetUtils.isEmail(value)) {
                                    return "Please enter a valid email";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primary,
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.error,
                                      width: 2.w,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: AppColors.textTertiary,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 20.h),
                              
                              // Phone Field
                              Text(
                                "Phone Number",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter your phone number";
                                  } else if (value.trim().length < 10) {
                                    return "Please enter a valid phone number";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primary,
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Enter your phone number",
                                  hintStyle: TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.error,
                                      width: 2.w,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone_outlined,
                                    color: AppColors.textTertiary,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 20.h),
                              
                              // City Field
                              Text(
                                "City",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter your city";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primary,
                                controller: controller.userCityController,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  hintText: "Enter your city",
                                  hintStyle: TextStyle(
                                    color: AppColors.textTertiary,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                    borderSide: BorderSide(
                                      color: AppColors.error,
                                      width: 2.w,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 16.h,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_city_outlined,
                                    color: AppColors.textTertiary,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 20.h),
                              
                              // Password Field
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Obx(
                                () => TextFormField(
                                  obscureText: !controller.password.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Please enter your password";
                                    } else if (value.length < 6) {
                                      return "Password must be at least 6 characters";
                                    }
                                    return null;
                                  },
                                  cursorColor: AppColors.primary,
                                  controller: controller.passController,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(
                                      color: AppColors.textTertiary,
                                      fontSize: 16.sp,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.background,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 2.w,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide(
                                        color: AppColors.error,
                                        width: 2.w,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 16.h,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: AppColors.textTertiary,
                                      size: 20.sp,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.tapOnToggle();
                                      },
                                      icon: Icon(
                                        controller.password.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.textTertiary,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 32.h),
                              
                              // Register Button
                              Obx(
                                () => Container(
                                  width: double.infinity,
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
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();
                                            if (formKey.currentState!.validate()) {
                                              controller.signup();
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                    ),
                                    child: controller.isLoading.value
                                        ? SizedBox(
                                            width: 24.w,
                                            height: 24.w,
                                            child: const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            "Create Account",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 32.h),
                      
                      // Sign In Link
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(AppRoutes.login);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
