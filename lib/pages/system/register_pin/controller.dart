import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class RegisterPinController extends GetxController {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();

  RegisterPinController();

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

  /// 提交按钮返回:
  void onButtonSubmit(String? value) {
    debugPrint("onButtonSubmit => $value");
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
    return value == '111111' ? null : LocaleKeys.commonMessageIncorrect.trParams({"method": "Pin"});
  }
}
