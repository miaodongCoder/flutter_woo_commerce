import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import '../../../common/models/request/product.dart';

class HomeController extends GetxController {
  int currentBannerIndex = 0;
  List<KeyValueModel<dynamic>> bannerItems = [];
  // 分类导航数据:
  List<CategoryModel> categoryItems = [];
  // 推荐商品列表数据:
  List<ProductModel> recommendProductList = [];
  // 最新商品列表数据:
  List<ProductModel> latestProductList = [];

  HomeController();
  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void onChangeBanner(int index, CarouselPageChangedReason reason) {
    currentBannerIndex = index;
    update(['home_banner']);
  }

  /// 分类点击事件:
  void onCategoryTap(int categoryId) {}

  /// 导航点击事件:
  void onAppBarTap() {}

  /// `全部`按钮点击事件:
  /// featured: 是否为推荐商品~
  void onAllBarTap(bool featured) {}

  _initData() async {
    // 轮播图:
    bannerItems = await SystemApi.banners();
    // 分类:
    categoryItems = await ProductApi.categories();
    // 推荐商品:
    recommendProductList = await ProductApi.products(ProductsReq(featured: true));
    // 新商品:
    latestProductList = await ProductApi.products(ProductsReq());

    update(["home"]);
  }
}
