import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';

class ProfileEditController extends GetxController {
  // 表单 form:
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // 输入框控制器:
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  ProfileEditController();

  _initData() {
    // 用户 profile:
    UserProfileModel profile = UserService.to.profile;
    // 初始值:
    firstNameController.text = profile.firstName ?? "";
    lastNameController.text = profile.lastName ?? "";
    emailController.text = profile.email ?? "";
    update(["profile_edit"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
