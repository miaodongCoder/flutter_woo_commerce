import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/common/widgets/text_form.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import 'index.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("login")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  // 主视图:
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        PageTitleWidget(
          title: LocaleKeys.loginBackTitle.tr,
          desc: LocaleKeys.loginBackDesc.tr,
        ),
        // 表单:
        _buildForm().card(),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .paddingHorizontal(
            AppSpace.page,
          ),
    );
  }

  // 表单:
  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: <Widget>[
        // 用户名:
        TextFormWidget(
          autofocus: true,
          controller: controller.userNameController,
          validator: Validatorless.multiple(
            [
              Validatorless.required(LocaleKeys.validatorRequired.tr),
              Validatorless.min(
                  3, LocaleKeys.validatorMin.trParams({"size": "3"})),
              Validatorless.max(
                  20, LocaleKeys.validatorMin.trParams({"size": "20"})),
            ],
          ),
        ).paddingBottom(AppSpace.listRow.w),
        // 密码:
        TextFormWidget(
          autofocus: true,
          controller: controller.passwordController,
          labelText: LocaleKeys.registerFormPassword.tr,
          isObscure: true,
          validator: Validatorless.multiple(
            [
              Validatorless.required(LocaleKeys.validatorRequired.tr),
              Validators.password(
                  6,
                  18,
                  LocaleKeys.validatorPassword
                      .trParams({"min": "6", "max": "18"})),
            ],
          ),
        ).paddingBottom(AppSpace.listRow.w),
        // 忘记密码:
        TextWidget.body1(LocaleKeys.loginForgotPassword.tr)
            .alignRight()
            .paddingBottom(50.w),

        // 登录按钮:
        ButtonWidget.primary(
          LocaleKeys.loginSignIn.tr,
          onTap: () => controller.onSignIn(),
        ).paddingBottom(30.w),
        // - OR -
        TextWidget.body1(LocaleKeys.loginOrText.tr).paddingBottom(30.w),

        <Widget>[
          // 其他登录按钮:
          ButtonWidget.iconTextOutlined(
            const IconWidget.svg(AssetsSvgs.facebookSvg),
            "Facebook",
            borderColor: AppColors.surfaceVariant,
            width: 149.w,
            height: 44.w,
          ),
          ButtonWidget.iconTextOutlined(
            const IconWidget.svg(AssetsSvgs.googleSvg),
            "Google",
            borderColor: AppColors.surfaceVariant,
            width: 149.w,
            height: 44.w,
          ),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ].toColumn(),
    ).paddingAll(AppSpace.card);
  }
}
