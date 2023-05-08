import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController userNameController = TextEditingController(text: "userName");
  TextEditingController emailController = TextEditingController(text: "email");
  TextEditingController firstNameController = TextEditingController(text: "firstName");
  TextEditingController lastNameController = TextEditingController(text: "lastName");
  TextEditingController passwordController = TextEditingController(text: "password");

  GlobalKey formKey = GlobalKey<FormState>();

  RegisterController();

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() {
    update(["register"]);
  }

  @override
  void onClose() {
    super.onClose();

    userNameController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
  }

  /// 注册:
  void onSignUp() {
    final state = formKey.currentState as FormState;
    if (state.validate()) {
      // 验证通过, 提交表单数据:
    }
  }

  /// 登录:
  void onSignIn() {}
}
