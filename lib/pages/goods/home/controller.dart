import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  _initData() {
    update(["home"]);
  }

  /// 导航点击事件:
  void onAppBarTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
