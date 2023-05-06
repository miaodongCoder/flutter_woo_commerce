import 'package:get/get.dart';

import '../../../common/index.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel;

class WelcomeController extends GetxController {
  List<WelcomeModel> items = [];
  int currentIndex = 0;
  bool isShowStartButton = false;
  // slider控制器:
  final carouselController = carousel.CarouselController();
  WelcomeController();

  void onPageChanged(int index) {
    currentIndex = index;
    if (items.isNotEmpty) isShowStartButton = (index == (items.length - 1));
    // 监听索引的变化重新触发 view中绑定的 `welcomeBar`
    // 重新build里面的builder Widget(SliderIndocatorWidget)
    update(['welcomeSlider', 'welcomeBar']);
  }

  /// 去首页:
  void onToMain() {
    Get.offAllNamed(RouteNames.systemMain);
  }

  /// 去下一页:
  void onToNext() {
    carouselController.nextPage();
  }

  // .tr自动根据key转换中英文多语言~
  _initData() {
    // 通知数据填充视图:
    update(["welcomeSlider"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onInit() {
    super.onInit();

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
  }
}
