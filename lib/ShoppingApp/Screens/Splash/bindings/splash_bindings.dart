import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/splash_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
