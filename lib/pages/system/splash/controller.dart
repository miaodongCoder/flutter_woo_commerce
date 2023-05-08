import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  void onReady() {
    super.onReady();
    _initData();
    _jumpToPage();
  }

  _initData() {
    // // 删除设备启动图:
    FlutterNativeSplash.remove();
    // if (ConfigService.to.isAlreadyOpen) {
    //   Get.offAllNamed(RouteNames.main);
    // } else {
    //   Get.offAllNamed(RouteNames.systemWelcome);
    // }
    // update(["splash"]);
  }

  _jumpToPage() {
    Get.offAllNamed(RouteNames.main);
  }
}
