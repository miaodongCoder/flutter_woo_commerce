import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashController();

  _initData() {
    // 删除设备启动图:
    FlutterNativeSplash.remove();
    update(["splash"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
