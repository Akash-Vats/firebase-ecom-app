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
    isLoading.value = true;

    try {
      User? user= await FirebaseServices().registerWithEmail(emailController.text, passController.text,userNameController.text,phoneController.text,userCityController.text);
      if(user!=null){
        print("Registration successful: ${user.email}");
        Get.offAllNamed(AppRoutes.login);
        CommonSnackbar.showSuccess(title: 'Success', message: 'Register Successfully');
      }

    } catch (e) {

      CommonSnackbar.showError(title: 'Failed', message: e.toString());


    } finally {
      isLoading.value = false;
      emailController.clear();
      passController.clear();
    }
  }
}