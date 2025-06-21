import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../services/Auth_services.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool isLoading=false.obs;

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  final formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true; // Start loading

      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final username = usernameController.text.trim();

      try {
        User? user = await _authService.registerWithEmail(email, password, username);

        if (user != null) {
          Get.snackbar("Success", "User registered successfully",
              snackPosition: SnackPosition.BOTTOM);
          // Optionally: navigate to home or login
        } else {
          Get.snackbar("Error", "Registration failed",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Error", "Something went wrong: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      } finally {
        isLoading.value = false; // Stop loading
      }
    }
  }
}
