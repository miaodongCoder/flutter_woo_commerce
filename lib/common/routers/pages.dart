import 'package:flutter_woo_commerce/pages/system/login/index.dart';
import 'package:flutter_woo_commerce/pages/system/splash/index.dart';
import 'package:get/route_manager.dart';

class RoutePages {
  static List<GetPage> list = [
    GetPage(
      name: "/",
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
    ),
  ];
}
