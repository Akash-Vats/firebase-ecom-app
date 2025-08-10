import 'package:chat_app/ShoppingApp/Screens/Forgotpassword/bindings/forgot_password_binding.dart';
import 'package:chat_app/ShoppingApp/Screens/Forgotpassword/forgotpassword_screen.dart';
import 'package:chat_app/ShoppingApp/Screens/cartscreen/cart_screen.dart';
import 'package:chat_app/ShoppingApp/Screens/dashboard/dashboard_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../Screens/Login/bindings/login_binding.dart';
import '../Screens/Login/login_screen.dart';
import '../Screens/Register/bindings/signup_bindings.dart';
import '../Screens/Register/register_screen.dart';
import '../Screens/Splash/bindings/splash_bindings.dart';
import '../Screens/Splash/splash_screen.dart';
import '../Screens/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()
    ),
    GetPage(
        name: AppRoutes.register,
        page: () => SignupScreen(),
        binding: SignUpBinding()

    ),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginScreens(),
        binding: LoginBinding()

    ),
   /* GetPage(
        name: AppRoutes.profile,
        page: () => ProfileScreen(),
        binding: ProfileBinding()

    ),
    GetPage(
        name: AppRoutes.faceDetection,
        page: () => FaceDetectionScreen(),
        binding: FaceDetectorBinding()

    ),*/
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreens(),


    ),
    GetPage(
      name: AppRoutes.cartScreen,
      page: () =>  CartScreen(),


    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () =>  ForgotPasswordScreen(),
      binding: ForgotPasswordBinding()


    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () =>  const DashboardScreen(),



    ),
  ];
}