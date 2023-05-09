import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class RegisterPinController extends GetxController {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();

  RegisterPinController();

  UserRegisterReq? req = Get.arguments;

  _initData() {
    update(["register_pin"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  /// pin触发提交:
  void onPinSubmit(String value) {
    debugPrint("onPinSubmit $value");
  }

  /// 提交按钮提交:
  void onButtonSubmit(String? value) {
    debugPrint("onButtonSubmit => $value");
    _register();
  }

  /// 按钮返回:
  void onButtonBack() {
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    pinController.dispose();
  }

  /// 验证器:
  String? pinValidator(String? value) {
    return value == '111111'
        ? null
        : LocaleKeys.commonMessageIncorrect.trParams({"method": "Pin"});
  }

  // 注册:
  Future<void> _register() async {
    try {
      Loading.show();

      // 暂时提交, 后续修改aes 加密后处理:
      bool isOk = await UserApi.register(req);
      if (isOk) {
        Loading.success(
            LocaleKeys.commonMessageSuccess.trParams({"method": "Register"}));
        Get.back(result: true);
      }

      // Loading.success(LocaleKeys.commonMessageSuccess.trParams({"method": "Register"}));
    } finally {
      Loading.dismiss();
    }
  }
}
