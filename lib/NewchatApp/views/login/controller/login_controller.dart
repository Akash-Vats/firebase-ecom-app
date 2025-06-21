import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginnController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var obscurePassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        Get.snackbar("Success", "Login successful",
            snackPosition: SnackPosition.BOTTOM);
        // Navigate to Home Screen
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "Unknown error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
