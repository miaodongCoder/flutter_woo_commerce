import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';

class SearchFilterController extends GetxController {
  // 排序列表:
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

  // 在view中给scaffold设置一个key , 然后拿到这个key之后用来空值它里面的抽屉盒子的开关属性:
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // 价格浮动区间:
  final List<double> priceRange = [100, 1000];

  // 尺寸列表:
  List<KeyValueModel<AttributeModel>> sizes = [];
  // 选中的尺寸列表:
  List<String> sizeKeys = [];
  // 颜色列表:
  List<KeyValueModel<AttributeModel>> colors = [];
  // 选中的颜色列表:
  List<String> colorKeys = [];

  // 星级:
  int starValue = -1;

  SearchFilterController();

  _initData() {
    update(["search_filter"]);
  }

  @override
  onInit() async {
    super.onInit();
    await _loadColorAttributes();
    await _loadSizeAttributes();
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

  // 筛选 打开:
  void onFilterOpenTap() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  // 筛选 关闭:
  void onFilterCloseTap() {
    Get.back();
  }

  void onPriceRangeDragging(int handlerIndex, dynamic lowerValue, dynamic upperValue) {
    priceRange[0] = lowerValue as double;
    priceRange[1] = upperValue as double;
    update(["filter_price_range"]);
  }

  _loadColorAttributes() async {
    List<AttributeModel> attributeColors = await ProductApi.attributes(1);
    colors = attributeColors.map((AttributeModel attr) {
      return KeyValueModel(key: attr.name ?? "noColorKey", value: attr);
    }).toList();
  }

  _loadSizeAttributes() async {
    // 基础数据
    // 尺寸
    List<AttributeModel> attributeSizes = await ProductApi.attributes(2);
    sizes = attributeSizes.map((AttributeModel attr) {
      return KeyValueModel(key: attr.name ?? "noSizeKey", value: attr);
    }).toList();
  }

  // 尺寸选中:
  void onSizeTap(List<String> keys) {
    sizeKeys = keys;
    update(["filter_sizes"]);
  }

  void onColorTap(List<String> keys) {
    colorKeys = keys;
    update(["filter_colors"]);
  }

  void onStarTap(int value) {
    starValue = value;
    update(["filter_stars"]);
  }
}
