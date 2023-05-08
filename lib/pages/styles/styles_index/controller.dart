import 'package:get/get.dart';

import '../../../common/index.dart';

class StylesIndexController extends GetxController {
  StylesIndexController();

  @override
  void onReady() {
    super.onReady();
    _updateData();
  }

  // 多语言切换:
  onLanguageSelected() {
    var en = Translation.supportedLocales[0];
    var zh = Translation.supportedLocales[1];

    ConfigService.to.onLocaleUpdate(
        ConfigService.to.locale.toLanguageTag() == en.toLanguageTag()
            ? zh
            : en);
    _updateData();
  }

  // 主题切换:
  onThemeSelected() async {
    await ConfigService.to.switchThemeModel();
    _updateData();
  }

  // 更新状态:
  _updateData() {
    update(["styles_index"]);
  }
}
