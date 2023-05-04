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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.systemSplash,
      getPages: RoutePages.list,
      navigatorObservers: [
        RoutePages.observer,
      ],
    );
  }
}
