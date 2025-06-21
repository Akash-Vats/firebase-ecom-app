import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_textfiled.dart';
import 'controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                "Create Account",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Username
               CommonTextFormField(
                label: "Username",
                controller: controller.usernameController,
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a username' : null,
              ),
              const SizedBox(height: 16),

              // Email
              CommonTextFormField(
                label: "Email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter an email';
                  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$");
                  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              Obx(() => CommonTextFormField(
                label: "Password",
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscurePassword.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: controller.togglePasswordVisibility,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter password';
                  if (value.length < 6) return 'Min 6 characters';
                  return null;
                },
              )),
              const SizedBox(height: 16),

              // Confirm Password
              Obx(() => CommonTextFormField(
                label: "Confirm Password",
                controller: controller.confirmPasswordController,
                obscureText: controller.obscureConfirmPassword.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.obscureConfirmPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
                validator: (value) {
                  if (value != controller.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 24),

              // Register Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.registerUser,
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text("Register"),
                ),
              )),
              const SizedBox(height: 16),

              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to login
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
