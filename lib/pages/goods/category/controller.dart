import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/index.dart';
import '../../../common/models/request/product.dart';

class CategoryController extends GetxController {
  // 分类 id , 获取路由传递参数
  int? categoryId = Get.arguments['id'];

  // 分类导航数据
  List<CategoryModel> categoryItems = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  // 商品数据源数组:
  List<ProductModel> items = [];
  // 页码:
  int _page = 1;
  // 每一页多少个item数据:
  final int _limit = 20;

  CategoryController();

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  // 初始数据
  _initData() async {
    // 读缓存
    var stringCategories =
        Storage().getString(Constants.storageProductsCategories);
    categoryItems = stringCategories != ""
        ? jsonDecode(stringCategories).map<CategoryModel>((item) {
            return CategoryModel.fromJson(item);
          }).toList()
        : [];

    // 如果本地缓存空: 因为有的时候启动App不是按顺序进来的页面 , 有可能是其它的活动页进来的;
    if (categoryItems.isEmpty) {
      categoryItems = await ProductApi.categories(); // 获取分类数据
    }

    update(["left_nav"]);
  }

  // 已经进入分类菜单页,点击其他分类菜单分类点击事件
  void onCategoryTap(int id) async {
    if (categoryId == id) return;
    categoryId = id;
    refreshController.requestRefresh();
    update(["left_nav"]);
  }

  // 拉取数据
  // isRefresh 是否是刷新
  Future<bool> _loadSearch(bool isRefresh) async {
    // 拉取数据
    var result = await ProductApi.products(ProductsReq(
      // 刷新, 重置页数1
      page: isRefresh ? 1 : _page,
      // 每页条数
      prePage: _limit,
    ));

    // 下拉刷新
    if (isRefresh) {
      _page = 1; // 重置页数1
      items.clear(); // 清空数据
    }

    // 有数据
    if (result.isNotEmpty) {
      // 页数+1
      _page++;

      // 添加数据
      items.addAll(result);
      items.addAll(result);
      items.addAll(result);
    }

    // 是否空
    return result.isEmpty;
  }

  // 上拉载入新商品
  void onLoading() async {
    if (items.isNotEmpty) {
      try {
        // 拉取数据是否为空
        var isEmpty = await _loadSearch(false);
        // isEmpty请求完周自动回给数据源添加数据 , 这里完全不用操作数据源 , 只需根据数据源的有无数据的情况来调整显示逻辑即可!
        if (isEmpty) {
          // 设置无数据
          refreshController.loadNoData();
        } else {
          // 加载完成
          refreshController.loadComplete();
        }
      } catch (e) {
        // 加载失败
        refreshController.loadFailed();
      }
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
    update(["product_list"]);
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      await _loadSearch(true);
      refreshController.refreshCompleted();
    } catch (error) {
      // 刷新失败
      refreshController.refreshFailed();
    }
    update(["product_list"]);
  }
}
