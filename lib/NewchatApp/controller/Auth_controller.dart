import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/Auth_services.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  var currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _authService.getCurrentUser();
  }

  // Register a new user
  Future<void> registerUser(String email, String password, String username) async {
    User? user = await _authService.registerWithEmail(email, password, username);
    if (user != null) {
      currentUser.value = user;

      Get.offAllNamed('/chat');
    } else {
      Get.snackbar('Error', 'Registration failed. Please try again.');
    }
  }

  // Sign in existing user
  Future<void> signInUser(String email, String password) async {
    User? user = await _authService.signInWithEmail(email, password);
    if (user != null) {
      currentUser.value = user;
      // Navigate to chat screen or home after successful sign-in
      Get.offAllNamed('/chat'); // Assuming you have a route for chat
    } else {
      Get.snackbar('Error', 'Sign-in failed. Please try again.');
    }
  }

  // Sign out user
  Future<void> signOutUser() async {
    await _authService.signOut();
    currentUser.value = null;
    Get.offAllNamed('/login');
  }
}
