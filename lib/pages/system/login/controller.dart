import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/common/utils/encrypt.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController userNameController =
      TextEditingController(text: "miaodong");
  TextEditingController passwordController =
      TextEditingController(text: "123456");
  GlobalKey formKey = GlobalKey<FormState>();
  LoginController();

  _initData() {
    update(["login"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  /// 登录:
  void onSignIn() async {
    FormState state = formKey.currentState as FormState;
    if (state.validate()) {
      try {
        Loading.show();
        String userName = userNameController.text;
        String password = EncryptUtil().aesEncode(passwordController.text);
        // 1.登录请求获取token:
        UserLoginReq? req =
            UserLoginReq(username: userName, password: password);
        UserTokenModel result = await UserApi.login(req);
        // 2.本地保存token:
        if (result.token == null) {
          debugPrint("Token == null error");
          return;
        }
        await UserService.to.setToken(result.token!);
        // 根据token获取用户资料:
        await UserService.to.getProfile();
        Loading.success();
        Get.back(result: true);
      } finally {
        Loading.dismiss();
      }
    }
  }

  /// 登出:
  void onSignUp() {
    Get.offNamed(RouteNames.systemRegister);
  }

  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
