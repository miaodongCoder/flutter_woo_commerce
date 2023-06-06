import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 5 定义 tag 值，唯一即可:
  final String tag = '${Get.arguments['id'] ?? ''}${UniqueKey()}';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _ProductDetailsViewGetX(tag);
  }
}

class _ProductDetailsViewGetX extends GetView<ProductDetailsController> {
  // 1.定义唯一标识符:
  final String uniqueTag;
  // 2. 接收传入的tag值:
  const _ProductDetailsViewGetX(this.uniqueTag, {Key? key}) : super(key: key);
  // 3.重写GetView的属性tag(对于商品详情页的 GetView 实例 , 是通过不同的tag值来作区分的 , 不同的商品有自己不同的tag值):
  @override
  String? get tag => uniqueTag;

  // 主视图
  Widget _buildView() {
    return controller.productModel == null
        ? const PlaceholderWidget()
        : <Widget>[
            // 滚动图:
            _buildBanner(),
            // 商品标题:
            _buildTitle(),
            // Tab 栏位:
            _buildTabBar(),
            // TabView 视图:
            _buildTabView(),
            // 加入购物车按钮:
            _buildAddToCartButtons(),
          ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      id: "product_details",
      // 4 GetBuilder属性设置tag值:
      tag: tag,
      builder: (_) {
        return Scaffold(
          appBar: mainAppBarWidget(titleString: controller.productModel?.name ?? LocaleKeys.gDetailTitle.tr),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  // 滚动图
  Widget _buildBanner() {
    return GetBuilder(
      init: ProductDetailsController(),
      id: 'product_banner',
      tag: tag,
      builder: (controller) {
        return CarouselWidget(
          items: controller.bannerItems,
          currentIndex: controller.bannerCurrentIndex,
          onPageChanged: controller.onChangeBannner,
          height: 190.w,
          // 大图预览:
          onTap: controller.onGalleryTap,
          indicatorCircle: false,
          indicatorAlignment: MainAxisAlignment.start,
          indicatorColor: AppColors.highlight,
        );
      },
    ).backgroundColor(AppColors.surfaceVariant);
  }

  // 商品标题
  Widget _buildTitle() {
    return <Widget>[
      // 金额、打分、喜欢:
      <Widget>[
        // 金额:
        TextWidget.title1(
          "💰 ${controller.productModel?.price ?? 0}",
        ).expanded(),
        // 打分:
        const IconTextWidget(
          iconData: Icons.star,
          text: "4.5",
        ).paddingRight(AppSpace.iconTextSmail),
        // 喜欢:
        const IconTextWidget(
          iconData: Icons.favorite,
          text: "100 +",
        ),
      ].toRow(),
      // 次标题:
      TextWidget.body1(
        controller.productModel?.shortDescription?.clearHtml ?? "-",
      ),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .paddingAll(AppSpace.page);
  }

  // Tab 栏位:
  Widget _buildTabBar() {
    return GetBuilder(
      init: ProductDetailsController(),
      tag: tag,
      id: "product_tab",
      builder: (controller) {
        return <Widget>[
          for (int i = 0; i < controller.tabTitles.length; i++) _buildTabBarItem(controller.tabTitles[i], i),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  Widget _buildTabBarItem(String textString, int index) {
    return ButtonWidget.textFilled(
      textString,
      onTap: () => controller.onChangeTabController(index),
      borderRadius: 17,
      textColor: controller.tabIndex == index ? AppColors.onPrimary : AppColors.secondary,
      bgColor: controller.tabIndex == index ? AppColors.primary : Colors.transparent,
    ).tight(
      width: 100.w,
      height: 35.h,
    );
  }

  // TabView 视图
  Widget _buildTabView() {
    return TabBarView(
      controller: controller.tabController,
      physics: const BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.down,
      children: [
        // 规格
        TabProductView(uniqueTag: uniqueTag),
        // 详情
        TabDetailView(uniqueTag: uniqueTag),
        // 评论
        TabReviewsView(uniqueTag: uniqueTag),
      ],
    ).paddingHorizontal(20.w).expanded();
  }

  Widget _buildAddToCartButtons() {
    return controller.productModel == null
        ? const SizedBox.shrink()
        : <Widget>[
            // 加入购物车:
            ButtonWidget.secondary(
              LocaleKeys.gDetailBtnAddCart.tr,
              onTap: controller.addToCartTap,
            ).expanded(),
            SizedBox(width: AppSpace.iconTextLarge),
            // 立刻购买
            ButtonWidget.primary(
              LocaleKeys.gDetailBtnBuy.tr,
              // 点击弹出购买窗口
              onTap: controller.onCheckoutTap,
            ).expanded(),
          ]
            .toRow(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )
            .paddingHorizontal(AppSpace.page);
  }
}
