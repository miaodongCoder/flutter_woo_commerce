import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigService extends GetxService {
  // 外部通过单例对象获取当前类对象:
  static ConfigService get to => Get.find<ConfigService>();
  // 这是一个内部私有的成员 , 外部能拿到的只有version属性:
  PackageInfo? _platform;
  String get version => _platform?.version ?? "-";
  Locale locale = PlatformDispatcher.instance.locale;
  // 主题:
  final RxBool _isDarkModel = Get.isDarkMode.obs;
  bool get isDarkModel => _isDarkModel.value;

  bool get isAlreadyOpen => Storage().getBool(Constants.storageAlreadyOpen);

  @override
  void onReady() {
    super.onReady();
    getPlatform();
    initLocale();
    initTheme();
  }

  // App包信息初始化:
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 多语言初始:
  void initLocale() {
    // 先读取之前存储的language_code:
    var langCode = Storage().getString(Constants.storageLanguageCode);
    // 空不处理:
    if (langCode.isEmpty) return;
    // 拿到当前的语言:
    var index = Translation.supportedLocales.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = Translation.supportedLocales[index];
  }

  // 更改语言
  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    // 把当前用到的语种存储到本地:
    Storage().setString(Constants.storageLanguageCode, value.languageCode);
  }

  // 切换主题并保存到本地存储 下一次进入程序还能保证是之前的主题样式:
  Future<void> switchThemeModel() async {
    _isDarkModel.value = !_isDarkModel.value;
    Get.changeTheme(
      _isDarkModel.value == true ? AppTheme.dark : AppTheme.light,
    );
    await Storage().setString(Constants.storageThemeCode,
        _isDarkModel.value == true ? "dark" : "light");
  }

  // 初始化主题:
  void initTheme() {
    var themeCode = Storage().getString(Constants.storageThemeCode);
    _isDarkModel.value = themeCode == "dark" ? true : false;
    Get.changeTheme(
      themeCode == "dark" ? AppTheme.dark : AppTheme.light,
    );
  }

  /// 标记已打开App:
  set isAlreadyOpen(bool already) =>
      Storage().setBool(Constants.storageAlreadyOpen, already);
}
