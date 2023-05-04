import 'package:get/get.dart';

import 'controller.dart';

/// 路由懒加载:
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
