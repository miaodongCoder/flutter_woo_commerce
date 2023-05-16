import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/global.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/index.dart';

void main() async {
  // 初始化全局的配置信息及与原生端的接口:
  await Global.init();
  // await保证初始化完成后才去运行App:
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 设计稿中的设备尺寸:
      designSize: const Size(414, 896),
      // 是否支持分屏尺寸:
      splitScreenMode: false,
      // 是否根据宽度高度中的最小值适配文字:
      minTextAdapt: false,
      builder: (context, child) {
        Widget child = GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ConfigService.to.isDarkModel ? AppTheme.dark : AppTheme.light,
          initialRoute: RouteNames.systemSplash,
          getPages: RoutePages.list,
          navigatorObservers: [
            RoutePages.observer,
          ],
          translations: Translation(), // 词典
          localizationsDelegates: Translation.localizationsDelegates, // 代理
          supportedLocales: Translation.supportedLocales, // 支持的语言种类
          locale: ConfigService.to.locale, // 当前语言种类
          fallbackLocale: Translation.fallbackLocale, // 默认语言种类
          builder: (context, widget) {
            // EasyLoading做初始化:
            widget = EasyLoading.init()(context, widget);
            // 不随系统字体缩放比例:
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget,
            );
          },
        );

        return RefreshConfiguration(
          headerBuilder: () => const ClassicHeader(), // 自定义刷新头部
          footerBuilder: () => const ClassicFooter(), // 自定义刷新尾部
          hideFooterWhenNotFull: true, // 当列表不满一页时,是否隐藏刷新尾部
          headerTriggerDistance: 80, // 触发刷新的距离
          maxOverScrollExtent: 100, // 最大的拖动距离
          footerTriggerDistance: 150, // 触发加载的距离
          child: child,
        );
      },
    );
  }
}
