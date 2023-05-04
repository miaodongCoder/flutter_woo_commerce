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
          onTap: controller.onLanguageSelected,
          title: Text(
            "语言 : ${ConfigService.to.locale.toLanguageTag()}",
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
