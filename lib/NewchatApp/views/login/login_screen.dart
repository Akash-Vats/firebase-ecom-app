import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/common_textfiled.dart';
import 'controller/login_controller.dart';

class LoginnScreen extends StatelessWidget {
  const LoginnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginnController());

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                "Welcome Back",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Email
              CommonTextFormField(
                label: "Email",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  final emailRegex =
                  RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$");
                  if (!emailRegex.hasMatch(value)) return 'Enter valid email';
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
              const SizedBox(height: 24),

              // Login Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.loginUser,
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text("Login"),
                ),
              )),
              const SizedBox(height: 16),

              // Don't have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to register screen
                    },
                    child: const Text("Register"),
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
