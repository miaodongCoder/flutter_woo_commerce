import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      id: "welcome",
      builder: (_) {
        return Scaffold(
          body: _buildView(),
        );
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return <Widget>[
      _buildSlider(),
      // 控制栏:
      _buildBar(),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround).paddingAll(AppSpace.page);
  }

  Widget _buildSlider() {
    return GetBuilder<WelcomeController>(
      id: "welcomeSlider",
      init: controller,
      builder: (controller) {
        return controller.items.isEmpty
            ? const SizedBox()
            : WelcomeSliderWidget(
                controller.items,
                // slider与sliderIndicator绑定:
                carouselController: controller.carouselController,
                onPageChanged: controller.onPageChanged,
              );
      },
    );
  }

  Widget _buildBar() {
    return GetBuilder<WelcomeController>(
      id: "welcomeBar",
      init: controller,
      builder: (controller) {
        return controller.isShowStartButton
            ? ButtonWidget.primary(
                LocaleKeys.welcomeStart.tr,
                onTap: controller.onToMain,
              ).tight(
                width: double.infinity,
                height: 50.h,
              )
            : <Widget>[
                // 跳过:
                ButtonWidget.text(
                  LocaleKeys.welcomeSkip.tr,
                  onTap: controller.onToMain,
                ),
                // 指示器:
                SliderIndicatorWidget(
                  length: controller.items.length,
                  currentIndex: controller.currentIndex,
                  color: Colors.red,
                ),
                // 下一页:
                ButtonWidget.text(
                  LocaleKeys.welcomeNext.tr,
                  onTap: controller.onToNext,
                ),
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              );
      },
    );
  }
}
