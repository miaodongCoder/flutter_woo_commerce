import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    // flutter与原生端的接口进行初始化, 这样再进行Service组件的初始化才不易报错, 这个方法要在runApp之前调用!
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // 启动后清理不用的资源:
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // 配置Android系统样式:
    setSystemUi();

    /// 工具类:
    // 本地{K : V}存储的初始化:
    await Storage().init();
    Loading();

    /// 直接将Service注入到GetX框架管理(把当前的配置服务装载进内存中):
    /// 依赖的顺序要正确:
    // 注入配置服务:
    Get.put<ConfigService>(ConfigService());
    // 配置网络请求服务:
    Get.put<WPHttpService>(WPHttpService());

    ///配置用户服务类:
    Get.put<UserService>(UserService());
  }

// 系统样式
  static void setSystemUi() {
    if (GetPlatform.isMobile) {
      // 屏幕方向 竖直上
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // 透明状态栏
      // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent, // transparent status bar
      // ));
    }

    if (GetPlatform.isAndroid) {
      // 去除顶部系统下拉和底部系统按键
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      // 去掉底部系统按键
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      //     overlays: [SystemUiOverlay.bottom]);

      // 自定义样式
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        // 顶部状态栏颜色
        statusBarColor: Colors.transparent,
        // 该属性仅用于 iOS 设备顶部状态栏亮度
        // statusBarBrightness: Brightness.light,
        // 顶部状态栏图标的亮度
        // statusBarIconBrightness: Brightness.light,

        // 底部状态栏与主内容分割线颜色
        systemNavigationBarDividerColor: Colors.transparent,
        // 底部状态栏颜色
        systemNavigationBarColor: Colors.white,
        // 底部状态栏图标样式
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
