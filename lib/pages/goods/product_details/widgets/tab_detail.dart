import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 商品详情
class TabDetailView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabDetailView({Key? key, required this.uniqueTag}) : super(key: key);

  @override
  String? get tag => uniqueTag;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 说明:
      _buildTitle("Description"),
      _buildContent(controller.productModel?.description?.clearHtml),
      // SKU:
      _buildTitle("SKU"),
      _buildContent(controller.productModel?.sku ?? "-"),
      // price:
      _buildTitle("Price"),
      _buildContent(controller.productModel?.price ?? "-"),

      // 市场价:
      _buildTitle("Regular price"),
      _buildContent(controller.productModel?.regularPrice ?? "-"),
      // 重量:
      _buildTitle("Weight"),
      _buildContent(controller.productModel?.weight ?? "-"),
      // 尺寸:
      _buildTitle("dimensions"),
      _buildContent(
          "${controller.productModel?.dimensions?.length} x ${controller.productModel?.dimensions?.width} x ${controller.productModel?.dimensions?.height}"),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .scrollable()
        .paddingVertical(AppSpace.page * 2);
  }

  // 标题:
  Widget _buildTitle(String title) {
    return TextWidget.title3(title).paddingBottom(AppSpace.listRow);
  }

  // 内容:
  Widget _buildContent(String? title) {
    return TextWidget.title2(
      title ?? '-',
      softWrap: true,
      maxLines: 10,
    ).paddingBottom(AppSpace.listRow * 2);
  }
}
