import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/common/models/request/product.dart';
import 'package:flutter_woo_commerce/common/models/woo/review_model/review_model.dart';
import 'package:flutter_woo_commerce/pages/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  // 评论 刷新控制器
  final RefreshController reviewsRefreshController = RefreshController(
    initialRefresh: true,
  );
  // reviews 评论列表
  List<ReviewModel> reviews = [];
  // 评论图片列表 测试用
  List<String> reviewImages = [];
  // 评论 页码
  int _reviewsPage = 1;
  // 评论 页尺寸
  final int _reviewsLimit = 20;

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
    reviewsRefreshController.dispose();
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

    // 评论
    reviews = await ProductApi.reviews(ReviewsReq(
      page: 1,
      prePage: 10,
      product: productId,
    ));

    // 评论图片，测试用
    reviewImages.addAll([
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/718Y%2BhJkMgL._AC_UY695_.jpg",
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/71n8Tg2ClZL._AC_UY695_.jpg",
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/819mEKajDML._AC_UY695_.jpg",
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/81J0UFuJHdL._AC_UY695_.jpg",
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/81M4BxGW4TL._AC_UY695_.jpg",
      "https://ducafecat.oss-cn-beijing.aliyuncs.com/bag/81s6OXEsZCL._AC_UY695_.jpg",
    ]);
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

  void onChangeBannner(int index, CarouselPageChangedReason reason) {
    bannerCurrentIndex = index;
    update(["product_banner"]);
  }

  void onColorTap(List<String> keys) {
    colorKeys = keys;
    update(["product_colors"]);
  }

  void onSizeTap(List<String> keys) {
    sizeKeys = keys;
    update(["product_sizes"]);
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

  /// 评论 拉取数据:
  Future<bool> _loadReviews(bool isRefresh) async {
    // 评论:
    var reviewsListTmp = await ProductApi.reviews(ReviewsReq(
      // 刷新, 重置页码为 1:
      page: isRefresh ? 1 : _reviewsPage,
      // 每页条数:
      prePage: _reviewsLimit,
      // 商品id:
      product: productId,
    ));

    // 更新评论数据:
    if (isRefresh) {
      _reviewsPage = 1; // 重置页数1
      reviews.clear(); // 清空数据
    }

    if (reviewsListTmp.isNotEmpty) {
      _reviewsPage++; // 页数 + 1
      reviews.addAll(reviewsListTmp); // 添加数据
    }

    // 这一次的请求是否有数据:
    return reviewsListTmp.isEmpty;
  }

  // 评论 下拉刷新
  void onReviewsRefresh() async {
    try {
      // 拉取数据是否为空
      await _loadReviews(true);

      // 刷新完成
      reviewsRefreshController.refreshCompleted();
    } catch (error) {
      // 刷新失败
      reviewsRefreshController.refreshFailed();
    }
    update(["product_reviews"]);
  }

  // 评论 上拉载入新商品
  void onReviewsLoading() async {
    if (reviews.isNotEmpty) {
      try {
        // 拉取数据是否为空
        var isEmpty = await _loadReviews(false);

        if (isEmpty) {
          // 设置无数据
          reviewsRefreshController.loadNoData();
        } else {
          // 加载完成
          reviewsRefreshController.loadComplete();
        }
      } catch (e) {
        // 加载失败
        reviewsRefreshController.loadFailed();
      }
    } else {
      // 设置无数据
      reviewsRefreshController.loadNoData();
    }
    update(["product_reviews"]);
  }

  // 评论图片浏览:
  void onReviewsGalleryTap(int index) {
    Get.to(GalleryWidget(
      initialIndex: index,
      items: reviewImages,
    ));
  }

  void addToCartTap() async {
    // 检查是否登录:
    if (!await UserService.to.checkIsLogin()) return;
    if (productModel == null || productModel?.id == null) {
      Loading.error("product is empty!");
      return;
    }

    // 加入购物车:
    CartService.to.addToCart(LineItem(
      productId: productId,
      product: productModel,
    ));

    // 加入购物车后退出商品详情页:
    Get.back();
  }

  // 立刻购买 checkout:
  void onCheckoutTap() async {
    // 检查是否登录
    if (!await UserService.to.checkIsLogin()) {
      return;
    }

    // 检查空
    if (productModel == null || productModel?.id == null) {
      Loading.error("product is empty");
      return;
    }

    // 立刻购买 checkout
    ActionBottomSheet.barModel(
      BuyNowPage(productModel: productModel!),
    );
  }
}
