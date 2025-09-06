import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


import '../../../AppRoutes/app_routes.dart';
import '../../../Common/common_snackbars.dart';
import '../../../Services/firebase_services.dart';


class SignUpController extends GetxController{

  RxBool password = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userCityController = TextEditingController();
  RxBool isLoading=false.obs;



  void tapOnToggle(){
    password.value=!password.value;
  }

  Future<void> signup() async {
    if (userNameController.text.trim().isEmpty) {
      CommonSnackbar.showError(title: 'Error', message: 'Please enter your full name');
      return;
    }
    if (emailController.text.trim().isEmpty) {
      CommonSnackbar.showError(title: 'Error', message: 'Please enter your email address');
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      CommonSnackbar.showError(title: 'Error', message: 'Please enter your phone number');
      return;
    }
    if (userCityController.text.trim().isEmpty) {
      CommonSnackbar.showError(title: 'Error', message: 'Please enter your city');
      return;
    }
    if (passController.text.trim().isEmpty) {
      CommonSnackbar.showError(title: 'Error', message: 'Please enter your password');
      return;
    }
    if (passController.text.length < 6) {
      CommonSnackbar.showError(title: 'Error', message: 'Password must be at least 6 characters long');
      return;
    }

    isLoading.value = true;

    try {
      User? user = await FirebaseServices().registerWithEmail(
        emailController.text,
        passController.text,
        userNameController.text,
        phoneController.text,
        userCityController.text,
      );
      
      if (user != null) {
        print("Registration successful: ${user.email}");
        CommonSnackbar.showSuccess(
          title: 'Registration Successful!', 
          message: 'Account created successfully. Please verify your email before logging in.'
        );
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      if (e.toString().contains('email-already-in-use')) {
        errorMessage = 'An account with this email already exists. Please use a different email or try logging in.';
      } else if (e.toString().contains('weak-password')) {
        errorMessage = 'Password is too weak. Please choose a stronger password.';
      } else if (e.toString().contains('invalid-email')) {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.toString().contains('operation-not-allowed')) {
        errorMessage = 'Email registration is currently disabled. Please contact support.';
      }
      CommonSnackbar.showError(title: 'Registration Failed', message: errorMessage);
    } finally {
      isLoading.value = false;
      userNameController.clear();
      emailController.clear();
      phoneController.clear();
      userCityController.clear();
      passController.clear();
    }
  }
}