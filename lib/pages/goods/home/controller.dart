import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  // 刷新控制器:
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  int _page = 1;
  final int _limit = 20;

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

  /// 拉取最新商品数据:
  Future<bool> _loadNewsSell(bool isRefresh) async {
    var result = await ProductApi.products(
      ProductsReq(
        page: isRefresh ? 1 : _page,
        prePage: _limit,
      ),
    );

    // 下拉刷新:
    if (isRefresh) {
      _page = 1;
      latestProductList.clear();
    }

    // 有数据:
    if (result.isNotEmpty) {
      _page++;
      latestProductList.addAll(result);
    }

    return result.isEmpty;
  }

  /// 上拉加载更多新商品的数据:
  void onLoading() async {
    if (latestProductList.isNotEmpty) {
      try {
        var isEmpty = await _loadNewsSell(false);
        if (isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } catch (e) {
        refreshController.loadFailed();
      }
    } else {
      refreshController.loadNoData();
    }
    
    update(["home_news_sell"]);
  }

  /// 下拉刷新:
  void onRefresh() async {
    try {
      await _loadNewsSell(true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.loadNoData();
    }
    update(["home_news_sell"]);
  }

  @override
  void onClose() {
    super.dispose();

    refreshController.dispose();
  }
}
