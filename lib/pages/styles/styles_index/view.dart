import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class StylesIndexPage extends GetView<StylesIndexController> {
  const StylesIndexPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Column(
      children: [
        ListTile(
          onTap: () => controller.onLanguageSelected(),
          title: Text(
            "语言 : ${ConfigService.to.locale.toLanguageTag()}",
          ),
        ),
        ListTile(
          onTap: () => controller.onThemeSelected(),
          title: Text(
            "主题 : ${ConfigService.to.isDarkModel ? 'Dark' : 'Light'}",
          ),
        ),
        ListTile(
          onTap: () => Get.toNamed(RouteNames.stylesText),
          title: const Text(
            "文本",
          ),
        ),
        ListTile(
          onTap: () => Get.toNamed(RouteNames.stylesIcon),
          title: const TextWidget.body1(
            "icon图标",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StylesIndexController>(
      init: StylesIndexController(),
      id: "styles_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            // tr是一个扩展写法:
            title: Text(LocaleKeys.stylesTitle.tr),
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
