import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    // flutter与原生端的接口进行初始化, 这样再进行Service组件的初始化才不易报错, 这个方法要在runApp之前调用!
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      // 注入配置服务, 直接将Service注入到GetX框架管理(把当前的配置服务装载进内存中):
      Get.putAsync<ConfigService>(() async => ConfigService()),
      // 本地{K : V}存储的初始化:
      Storage().init(),
    ]).whenComplete(() {
      debugPrint('Global init complete!');
    });
  }
}
