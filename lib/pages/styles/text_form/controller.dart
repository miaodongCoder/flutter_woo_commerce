import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormController extends GetxController {
  GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController(text: "userName");

  TextEditingController passwordController = TextEditingController(text: "password");
  TextFormController();

  _initData() {
    update(["text_form"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();

    userNameController.dispose();
    passwordController.dispose();
  }
}
