import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // flutter与原生端的接口进行初始化, 这样再进行Service组件的初始化才不易报错, 这个方法要在runApp之前调用!
    WidgetsFlutterBinding.ensureInitialized();
    // 通过Get.put()方法直接将Service注入到GetX框架管理(把当前的配置服务装载进内存中):
    Get.put<ConfigService>(ConfigService());
  }
}
