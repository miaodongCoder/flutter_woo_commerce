import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    ////////////////////////////////////////////////
    // flutter与原生端的接口进行初始化, 这样再进行Service组件的初始化才不易报错, 这个方法要在runApp之前调用!
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // 启动后清理不用的资源:
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    ////////////////////////////////////////////////

    /// 工具类:
    // 本地{K : V}存储的初始化:
    await Storage().init();
    Loading();

    ////////////////////////////////////////////////

    /// 直接将Service注入到GetX框架管理(把当前的配置服务装载进内存中):
    /// 依赖的顺序要正确:
    // 注入配置服务:
    Get.put<ConfigService>(ConfigService());
    // 配置网络请求服务:
    Get.put<WPHttpService>(WPHttpService());
    ///配置用户服务类:
    Get.put<UserService>(UserService());
  }
}
