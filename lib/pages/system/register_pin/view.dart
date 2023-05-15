import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class RegisterPinPage extends GetView<RegisterPinController> {
  const RegisterPinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPinController>(
      init: RegisterPinController(),
      id: "register_pin",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("register_pin")),
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
          title: LocaleKeys.registerPinTitle.tr,
          desc: LocaleKeys.registerPinDesc.tr,
        ),
        // 表单:
        _buildForm().card(),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .paddingHorizontal(AppSpace.page),
    );
  }

  /// Pin表单页:
  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: <Widget>[
        // 提示文字:
        TextWidget.body1(LocaleKeys.registerPinFormTip.tr)
            .paddingBottom(20.w)
            .alignLeft(),
        // Pin:
        PinPutWidget(
          controller: controller.pinController,
          // 验证码输入是否正确:
          validator: (String? value) => controller.pinValidator(value),
          onSubmit: (String value) => controller.onPinSubmit(value),
        ).paddingBottom(50.w),
        // 提交按钮:
        ButtonWidget.primary(
          LocaleKeys.registerPinButton.tr,
          onTap: () {
            if (controller.pinController.text.isEmpty) return;
            controller.onButtonSubmit(controller.pinController.text);
          },
        ),
        // 返回按钮:
        ButtonWidget.text(
          LocaleKeys.commonBottomCancel.tr,
          onTap: () => controller.onButtonBack(),
        ),
      ].toColumn(),
    ).paddingAll(AppSpace.card);
  }
}
