import 'package:chat_app/ShoppingApp/Screens/Forgotpassword/controller/forgot_password_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';



class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put((ForgotPasswordController()));
  }
}
