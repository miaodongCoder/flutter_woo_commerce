import 'package:get/get.dart';

import '../../../common/index.dart';

class SearchFilterController extends GetxController {
  // 排序列表
  List<KeyValueModel> orderList = [
    KeyValueModel(key: "rating", value: "Best Match"),
    KeyValueModel(key: "price_low", value: "Price (low to high)"),
    KeyValueModel(key: "price_high", value: "Price (high to low)"),
    KeyValueModel(key: "popularity", value: "Popularity"),
    KeyValueModel(key: "date", value: "New publish"),
    KeyValueModel(key: "title", value: "Product name"),
    KeyValueModel(key: "slug", value: "Slug name"),
  ];

  // 排序选中:
  KeyValueModel orderSelected = KeyValueModel(key: "rating", value: "Best Match");

  SearchFilterController();

  _initData() {
    update(["search_filter"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void back() {
    Get.back();
  }

  // 排序选中
  void onOrderTap(KeyValueModel? val) {
    if (val == null) return;
    orderSelected = val;
    update(["search_filter"]);
  }

  void onFilterOpenTap() {}
}
