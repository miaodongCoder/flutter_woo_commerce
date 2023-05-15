import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';

class HomeController extends GetxController {
  int currentBannerIndex = 0;
  List<KeyValueModel<dynamic>> bannerItems = [];
  void onChangeBanner(int index, CarouselPageChangedReason reason) {
    currentBannerIndex = index;
    update(['home_banner']);
  }

  HomeController();

  _initData() async {
    bannerItems = await SystemApi.banners();
    update(["home"]);
  }

  /// 导航点击事件:
  void onAppBarTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
