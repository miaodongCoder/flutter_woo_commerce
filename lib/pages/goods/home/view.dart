import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/pages/goods/home/widgets/list_title.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
          body: SmartRefresher(
            controller: controller.refreshController, // 刷新控制器
            enablePullDown: true,
            header: const WaterDropHeader(),
            enablePullUp: true, // 启用上拉加载
            onRefresh: controller.onRefresh, // 下拉刷新回调
            onLoading: controller.onLoading, // 上拉加载回调
            footer: const SmartRefresherFooterWidget(), // 底部加载更多
            child: _buildView(),
          ),
        );
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return (controller.flashSellList.isEmpty || controller.newProductList.isEmpty)
        ? const PlaceholderWidget()
        : CustomScrollView(
            slivers: <Widget>[
              // 轮播广告:
              _buildBanner(),
              // 分类导航:
              _buildCategories(),
              // 推荐商品:
              if (controller.flashSellList.isNotEmpty) _buildSectionTitleWithTitle(LocaleKeys.gHomeFlashSell.tr),
              // 推荐商品列表:
              controller.flashSellList.isNotEmpty
                  ? _buildFlashSellList(controller.flashSellList)
                  : const SliverToBoxAdapter(),
              // 最新商品:
              if (controller.newProductList.isNotEmpty) _buildSectionTitleWithTitle(LocaleKeys.gHomeNewProduct.tr),
              // 最新商品列表:
              controller.newProductList.isNotEmpty
                  ? _buildLatestProductList(controller.newProductList)
                  : const SliverToBoxAdapter(),
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
          category: controller.categoryItems[i],
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
    return BuildListTitle(
      title: title,
      onTap: () => controller.onAllTap(false),
    ).sliverToBoxAdapter().sliverPaddingHorizontal(AppSpace.page);
  }

  // 推荐商品列表:
  Widget _buildFlashSellList(List<ProductModel> productList) {
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
    return GetBuilder<HomeController>(
      id: "home_news_sell",
      builder: (_) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int position) {
              var product = controller.newProductList[position];
              return ProductItemWidget(
                product,
                imgHeight: 170.w,
              );
            },
            // 显示个数:
            childCount: controller.newProductList.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppSpace.listRow,
            crossAxisSpacing: AppSpace.listItem,
            childAspectRatio: 0.8,
          ),
        ).sliverPadding(bottom: AppSpace.page).sliverPaddingHorizontal(AppSpace.page);
      },
    );
  }
}
