import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/models/request/user_register.dart';
import 'package:flutter_woo_commerce/common/routers/index.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController userNameController =
      TextEditingController(text: "userName");
  TextEditingController emailController = TextEditingController(text: "email");
  TextEditingController firstNameController =
      TextEditingController(text: "firstName");
  TextEditingController lastNameController =
      TextEditingController(text: "lastName");
  TextEditingController passwordController =
      TextEditingController(text: "password");

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
      // 密码的传递要做加密处理:
      var password = passwordController.text;
      // 验证通过, 提交表单数据:
      Get.offNamed(
        RouteNames.systemRegisterPin,
        arguments: UserRegisterReq(
          username: userNameController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          password: password,
        ),
      );
    }
  }

  /// 登录:
  void onSignIn() {
    // 把当前注册路由替换为登录路由, 基地址路由还是main:
    Get.offNamed(RouteNames.systemLogin);
  }
}
