import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../AppRoutes/app_routes.dart';
import '../../Common/app_colors.dart';
import '../../Common/app_images.dart';
import 'Controller/login_controller.dart';

class LoginScreens extends StatelessWidget {
  LoginScreens({super.key});
  final forKey = GlobalKey<FormState>();
  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Log in",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                  key: forKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please type email";
                          } else {
                            return null;
                          }
                        },
                        cursorColor: AppColors.primary,
                        controller: loginController.emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            hintText: "Enter Email",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color: AppColors.primary, width: 1.w)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.w)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.w))),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Obx(
                        () => TextFormField(
                          obscureText: !loginController.password.value,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please type password";
                            } else {
                              return null;
                            }
                          },
                          cursorColor: AppColors.primary,
                          controller: loginController.passController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              hintText: "Enter Password",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 1.w)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 1.w)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.w)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.tapOnToggle();
                                  },
                                  icon: loginController.password.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off))),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.forgot);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                            )),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    minimumSize: Size(320.w, 45.h),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r))),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (forKey.currentState!.validate()) {
                                    loginController.login();
                                  }
                                },
                                child: loginController.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text: " Register",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAllNamed(AppRoutes.register);
                          }),
                  ]),
            ),
            SizedBox(
              height: 100.h,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: Size(320.w, 45.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r))),
                      onPressed: () {
                   loginController.signInWithGoogle();
                      },
                      child: loginController.loading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(AppImages.google),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
