import 'package:get/get.dart';

class SplashController extends GetxController {
  String title = '';

  SplashController();

  _initData() {
    // update(["splash"]);
  }

  // 点击的时候更新标题名称:
  void onTap(int index) {
    title = '$index';
    // 做更新方法的通知操作:
    update(['splash_title']);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
