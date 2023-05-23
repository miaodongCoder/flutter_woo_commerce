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
    return const Text("商品标题");
  }

  // Tab 栏位
  Widget _buildTabBar() {
    return const Text("Tab 栏位");
  }

  // TabView 视图
  Widget _buildTabView() {
    return const Text("TabView 视图");
  }
}
