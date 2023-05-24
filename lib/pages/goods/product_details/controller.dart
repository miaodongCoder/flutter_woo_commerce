import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> tabTitles = [
    LocaleKeys.gDetailTabProduct.tr,
    LocaleKeys.gDetailTabDetails.tr,
    LocaleKeys.gDetailTabReviews.tr,
  ];
  int tabIndex = 0;

  ProductDetailsController();

  int productId = Get.arguments['id'] ?? 0;
  ProductModel? productModel;
  List<KeyValueModel> bannerItems = [];
  int bannerCurrentIndex = 0;

  // 颜色列表:
  List<KeyValueModel<AttributeModel>> colors = [];
  // 选中的颜色列表:
  List<String> colorKeys = [];
  // 尺寸列表
  List<KeyValueModel<AttributeModel>> sizes = [];
  // 选中尺寸列表
  List<String> sizeKeys = [];

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.removeListener(() {});
    tabController.dispose();
  }

  _initData() async {
    await _loadProduct();
    tabController = TabController(
      length: tabTitles.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );

    await _loadColorAttributes();
    await _loadSizeAttributes();

    /// 页面手动滑动会走这个监听回调:
    tabController.addListener(() {
      tabIndex = tabController.index;
      update(["product_tab"]);
    });
    update(["product_details"]);
  }

  _loadProduct() async {
    productModel = await ProductApi.productDetail(productId);
    if (productModel == null) return;
    if (productModel?.images != null) {
      bannerItems = productModel!.images!
          .map((image) => KeyValueModel(
                key: image.id.toString(),
                value: image.src,
              ))
          .toList();
    }

    // 初始一个默认的选中颜色、尺寸:
    if (productModel?.attributes != null) {
      // 颜色
      var colorAttr = productModel?.attributes?.where((e) => e.name == "Color");
      if (colorAttr?.isNotEmpty == true) {
        colorKeys = colorAttr?.first.options ?? [];
      }
      // 尺寸
      var sizeAttr = productModel?.attributes?.where((e) => e.name == "Size");
      if (sizeAttr?.isNotEmpty == true) {
        sizeKeys = sizeAttr?.first.options ?? [];
      }
    }
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

  void onColorTap(List<String> keys) {
    colorKeys = keys;
    update(["product_colors"]);
  }

  void onSizeTap(List<String> keys) {
    sizeKeys = keys;
    update(["product_sizes"]);
  }

  void onChangeBannner(int index, CarouselPageChangedReason reason) {
    bannerCurrentIndex = index;
    update(["product_banner"]);
  }

  void onGalleryTap(int index, KeyValueModel item) {
    Get.to(GalleryWidget(
      initialIndex: index,
      items: bannerItems.map<String>((KeyValueModel model) => model.value).toList(),
    ));
  }

  // 切换中间的 TabController:
  void onChangeTabController(int index) {
    tabIndex = index;
    tabController.animateTo(index);
    update(["product_tab"]);
  }
}
