import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

/// 各部分都需要用sliverBoxAdapter包装!
/// padding需要用sliverPaddingHorizontal!

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      id: "home",
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildView(),
        );
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return CustomScrollView(
      slivers: <Widget>[
        // 轮播广告:
        _buildBanner(),
        // 分类导航:
        _buildCategories(),
        // 推荐商品:
        _buildSectionTitleWithTitle(LocaleKeys.gHomeFlashSell.tr),
        // 推荐商品列表:
        if (controller.recommendProductList.isNotEmpty) _buildRecommendProductList(controller.recommendProductList),
        if (controller.recommendProductList.isEmpty) const SliverToBoxAdapter(),

        // 最新商品:
        _buildSectionTitleWithTitle(LocaleKeys.gHomeNewProduct.tr),
        // 最新商品列表:
        if (controller.latestProductList.isNotEmpty) _buildLatestProductList(controller.latestProductList),
        if (controller.latestProductList.isEmpty) const SliverToBoxAdapter(),
      ],
    );
  }

  // 导航栏:
  AppBar _buildAppBar() {
    return AppBar(
      // 背景透明
      backgroundColor: Colors.transparent,
      // 取消阴影
      elevation: 0,
      // 标题栏左侧间距
      titleSpacing: AppSpace.listItem,
      // 搜索栏
      title: InputWidget.search(
        // 提示文字，多语言
        hintText: LocaleKeys.gHomeNewProduct.tr,
        // 点击事件
        onTap: controller.onAppBarTap,
        // 只读
        readOnly: true,
      ),
      // 右侧的按钮区
      actions: [
        // 图标
        const IconWidget.svg(
          AssetsSvgs.pNotificationsSvg,
          size: 20,
          isDot: true, // 未读消息 小圆点
        )
            .unconstrained() // 去掉约束, appBar 会有个约束下来
            .padding(
              left: AppSpace.listItem,
              right: AppSpace.page,
            ),
      ],
    );
  }

  // 轮播广告:
  Widget _buildBanner() {
    return GetBuilder<HomeController>(
      init: controller,
      builder: (controller) {
        return CarouselWidget(
          items: controller.bannerItems,
          currentIndex: controller.currentBannerIndex,
          onPageChanged: controller.onChangeBanner,
          height: 190.w,
        );
      },
    ).clipRRect(all: AppSpace.button).sliverToBoxAdapter().sliverPaddingHorizontal(AppSpace.page);
  }

  // 分类导航横滑列表:
  Widget _buildCategories() {
    return <Widget>[
      for (var i = 0; i < controller.categoryItems.length; i++)
        CategoryListItemWidget(
          categoryModel: controller.categoryItems[i],
          onTap: (categoryId) => controller.onCategoryTap(categoryId),
        ).paddingRight(AppSpace.listItem),
    ]
        .toListView(scrollDirection: Axis.horizontal)
        .height(90.w)
        .paddingVertical(AppSpace.listRow)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  /// 商品列表的标题栏:
  Widget _buildSectionTitleWithTitle(String title) {
    return Text(title).sliverToBoxAdapter().sliverPaddingHorizontal(AppSpace.page);
  }

  // 推荐商品列表:
  Widget _buildRecommendProductList(List<ProductModel> productList) {
    return <Widget>[
      for (var i = 0; i < productList.length; i++)
        ProductItemWidget(
          productList[i],
          imgHeight: 117.w,
          imgWidth: 120.w,
        )
            .constrained(
              width: 120.w,
              height: 170.w,
            )
            .paddingRight(AppSpace.listItem)
    ]
        .toListView(
          scrollDirection: Axis.horizontal,
        )
        .height(170.w)
        .paddingBottom(AppSpace.listRow)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // 最新商品列表:
  Widget _buildLatestProductList(List<ProductModel> productList) {
    return <Widget>[
      for (var i = 0; i < productList.length; i++)
        ProductItemWidget(
          productList[i],
          imgHeight: 117.w,
          imgWidth: 120.w,
        )
            .constrained(
              width: 120.w,
              height: 170.w,
            )
            .paddingRight(AppSpace.listItem)
    ]
        .toListView(
          scrollDirection: Axis.horizontal,
        )
        .height(170.w)
        .paddingBottom(AppSpace.listRow)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }
}
