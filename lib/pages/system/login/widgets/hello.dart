import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

/// hello
class HelloWidget extends GetView<LoginController> {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // 数据是通过Obx触发更新的操作:
      child: Obx(() => Text(controller.state.title)),
    );
  }
}
