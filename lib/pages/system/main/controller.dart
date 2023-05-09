import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController();

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() async {
    // 读取用户 profile:
    await UserService.to.getProfile();
    // 这一行测试用:
    Get.toNamed(RouteNames.systemLogin);

    update(["main"]);
  }
}
