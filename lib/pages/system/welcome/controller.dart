import 'package:get/get.dart';

import '../../../common/index.dart';

class WelcomeController extends GetxController {
  List<WelcomeModel>? items;
  WelcomeController();

  // .tr自动根据key转换中英文多语言~
  _initData() {
    items = <WelcomeModel>[
      WelcomeModel(
        image: AssetsImage.welcome_1Png,
        title: LocaleKeys.welcomeOneTitle.tr,
        desc: LocaleKeys.welcomeOneDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImage.welcome_2Png,
        title: LocaleKeys.welcomeTwoTitle.tr,
        desc: LocaleKeys.welcomeTwoDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImage.welcome_3Png,
        title: LocaleKeys.welcomeThreeTitle.tr,
        desc: LocaleKeys.welcomeThreeDesc.tr,
      ),
    ];
    update(["welcomeSlider"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
