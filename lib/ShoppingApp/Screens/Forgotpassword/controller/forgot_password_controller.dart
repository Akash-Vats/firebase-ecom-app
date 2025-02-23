import 'package:chat_app/ShoppingApp/AppRoutes/app_routes.dart';
import 'package:chat_app/ShoppingApp/Common/common_snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{

  final FirebaseAuth _auth= FirebaseAuth.instance;
  RxBool isLoading=false.obs;
  Future<void>  forgotPassword(String email)async{
    try{
      isLoading.value=true;
      await _auth.sendPasswordResetEmail(email: email);
      isLoading.value=false;
      Get.toNamed(AppRoutes.login);
      CommonSnackbar.showSuccess(title: "Success", message:"Password reset link sent to$email");
    }catch(e){
      isLoading.value=false;
      CommonSnackbar.showError(title: "Error", message: e.toString());
    }


  }
}