import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // 分页管理控制器:
  final PageController pageController = PageController();
  int currentIndex = 0;
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

  void onIndexChanged(int index) {
    currentIndex = index;
    update(["main"]);
  }

  void onJumpToPage(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
