import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/components/page_title.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/common/widgets/text_form.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import 'index.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        PageTitleWidget(title: LocaleKeys.registerTitle.tr, desc: LocaleKeys.registerDesc.tr),
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      id: "register",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("register")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Form(
      // 设置globalKey, 用于后面获取FormState:
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: <Widget>[
        TextFormWidget(
          autofocus: true,
          controller: controller.userNameController,
          labelText: LocaleKeys.registerFormName.tr,
          validator: Validatorless.multiple([
            Validatorless.required(LocaleKeys.validatorRequired.tr),
            Validatorless.min(3, LocaleKeys.validatorMin.trParams({"size": "3"})),
            Validatorless.max(20, LocaleKeys.validatorMax.trParams({"size": "20"})),
          ]),
        ),
        TextFormWidget(
          autofocus: true,
          controller: controller.emailController,
          labelText: LocaleKeys.registerFormEmail.tr,
          prefixIcons: Icon(
            Icons.email_outlined,
            size: 20,
            color: AppColors.primary,
          ),
          validator: Validatorless.multiple([
            Validatorless.required(LocaleKeys.validatorRequired.tr),
            Validatorless.email(LocaleKeys.validatorEmail.tr),
          ]),
        ),
        // 姓:
        TextFormWidget(
          autofocus: true,
          controller: controller.firstNameController,
          labelText: LocaleKeys.registerFormFirstName.tr,
          validator: Validatorless.multiple([
            Validatorless.required(LocaleKeys.validatorRequired.tr),
            Validatorless.min(3, LocaleKeys.validatorMin.trParams({"size": "3"})),
            Validatorless.max(20, LocaleKeys.validatorMax.trParams({"size": "20"})),
          ]),
        ),
        // 名:
        TextFormWidget(
          autofocus: true,
          controller: controller.lastNameController,
          labelText: LocaleKeys.registerFormLastName.tr,
          validator: Validatorless.multiple([
            Validatorless.required(LocaleKeys.validatorRequired.tr),
            Validatorless.min(3, LocaleKeys.validatorMin.trParams({"size": "3"})),
            Validatorless.max(20, LocaleKeys.validatorMax.trParams({"size": "20"})),
          ]),
        ),
        TextFormWidget(
          autofocus: true,
          controller: controller.passwordController,
          labelText: LocaleKeys.registerFormPassword.tr,
          isObscure: true,
          validator: Validatorless.multiple([
            Validatorless.required(LocaleKeys.validatorRequired.tr),
            Validators.password(8, 18, LocaleKeys.validatorPassword.trParams({"min": "8", "max": "18"})),
          ]),
        ).paddingBottom(50),

        // 注册按钮:
        _buildBtnSignUp(),
        _buildTips(),
      ].toColumn(),
    ).paddingAll(AppSpace.card);
  }

  Widget _buildBtnSignUp() {
    return ButtonWidget.primary(
      LocaleKeys.loginSignUp.tr,
      onTap: () => controller.onSignUp(),
    ).paddingBottom(AppSpace.listRow);
  }

  Widget _buildTips() {
    return <Widget>[
      TextWidget.body2(LocaleKeys.registerHaveAccount.tr),
      ButtonWidget.text(
        LocaleKeys.loginSignIn.tr,
        onTap: () => controller.onSignIn(),
        textColor: AppColors.primary,
      ),
    ].toRow(mainAxisAlignment: MainAxisAlignment.center);
  }
}
