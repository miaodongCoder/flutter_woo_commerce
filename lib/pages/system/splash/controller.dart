import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_woo_commerce/common/routers/index.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  _initData() {
    // 删除设备启动图:
    FlutterNativeSplash.remove();
    _jumpToPage();
    update(["splash"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _jumpToPage() {
    // 启动屏后延时2秒显示欢迎页(轮播图):
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(
        RouteNames.systemWelcome,
      );
    });
  }
}
