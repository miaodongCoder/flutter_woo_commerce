import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/global.dart';
import 'package:get/route_manager.dart';

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
    return GetMaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: ConfigService.to.isDarkModel ? AppTheme.dark : AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.stylesStyleIndex,
      getPages: RoutePages.list,
      navigatorObservers: [
        RoutePages.observer,
      ],
      translations: Translation(), // 词典
      localizationsDelegates: Translation.localizationsDelegates, // 代理
      supportedLocales: Translation.supportedLocales, // 支持的语言种类
      locale: ConfigService.to.locale, // 当前语言种类
      fallbackLocale: Translation.fallbackLocale, // 默认语言种类
    );
  }
}
