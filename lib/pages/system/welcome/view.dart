import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return <Widget>[
      _buildSlider(),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingAll(
          AppSpace.page,
        );
  }

  Widget _buildSlider() {
    return GetBuilder<WelcomeController>(
      id: "welcomeSlider",
      init: controller,
      builder: (controller) {
        return controller.items == null
            ? const SizedBox()
            : WelcomeSliderWidget(
                controller.items!,
                onPageChanged: (index) {},
              );
      },
    );
  }

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
}
