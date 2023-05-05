import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class IconPage extends GetView<IconController> {
  const IconPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return ListView(
      children: const [
        ListTile(
          leading: IconWidget.icon(Icons.home),
          title: TextWidget.body1('IconWidget.icon'),
        ),
        ListTile(
          leading: IconWidget.image(AssetsImage.defaultPng),
          title: TextWidget.body1("IconWidget.image"),
        ),
        ListTile(
          leading: IconWidget.svg(AssetsSvgs.cHomeSvg),
          title: TextWidget.body1("IconWidget.svg"),
        ),
        ListTile(
          leading: IconWidget.url(
              'https://ducafecat.oss-cn-beijing.aliyuncs.com/flutter_woo_commerce_getx_ducafecat/categories/c-man.png'),
          title: TextWidget.body1("IconWidget.url"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IconController>(
      init: IconController(),
      id: "icon",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("icon")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
