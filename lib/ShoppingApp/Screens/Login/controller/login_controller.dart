import 'package:chat_app/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../AppRoutes/app_routes.dart';
import '../../../Common/common_snackbars.dart';
import '../../../Models/user_model.dart';
import '../../../Services/firebase_services.dart';



class LoginController extends GetxController{

  RxBool password = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isLoading=false.obs;
  RxBool loading=false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void tapOnToggle(){
    password.value=!password.value;
  }

  Future<void> login() async {
    isLoading.value = true;

    try {
      User? user= await FirebaseServices().signInWithEmail(emailController.text, passController.text);
      if(user!=null){
        if(user.emailVerified){
          print(" login succesfull${user.email}");
          Get.offAllNamed(AppRoutes.home);
          CommonSnackbar.showSuccess(title: 'Success', message: 'Login Successfully');
        }
        else{
          CommonSnackbar.showError(title: 'Error', message: 'Please verify your email first');
        }

      }
    } catch (e) {

      CommonSnackbar.showError(title: 'Error', message: e.toString());


    } finally {
      isLoading.value = false;
      emailController.clear();
      passController.clear();
    }
  }


  Future<void> signInWithGoogle() async {
    try {
      loading.value = true;


      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Sign In Cancelled', 'User cancelled the sign-in');
        loading.value = false;

        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        
        UserModel1 userModel=UserModel1(uid: user.uid, userName: user.displayName.toString(),
          phone: user.phoneNumber.toString(), userImg:user.photoURL.toString(),
          userDeviceToken: '', country: '', email: '', userAddress: '', street: '', isAdmin: false, isActive: true, userCity: '',);
        FirebaseFirestore.instance.collection("userss").doc(user.uid).set(userModel.toMap() );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    } finally {
      loading.value = false;
      update();
    }
  }

  Future<void> signOut() async {
    try {

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        Get.toNamed(AppRoutes.login);
      }

      await _auth.signOut();
      Get.toNamed(AppRoutes.login);
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }
}