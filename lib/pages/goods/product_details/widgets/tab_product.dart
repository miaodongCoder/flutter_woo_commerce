import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 商品规格
class TabProductView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabProductView({Key? key, required this.uniqueTag}) : super(key: key);

  @override
  String? get tag => uniqueTag;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 颜色:
      _buildTitle('Color'),
      GetBuilder(
        init: ProductDetailsController(),
        id: "product_colors",
        tag: tag,
        builder: (controller) {
          return ColorsListWidget(
            itemList: controller.colors,
            keys: controller.colorKeys,
            size: 33.w,
            onTap: controller.onColorTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),
      // 尺寸:
      _buildTitle("Size"),
      GetBuilder(
        init: ProductDetailsController(),
        id: "product_sizes",
        tag: tag,
        builder: (controller) {
          return TagsListWidget(
            itemList: controller.sizes,
            keys: controller.sizeKeys,
            onTap: controller.onSizeTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),
      // 运费说明:
      _buildTitle("Shipping Charge"),
      <Widget>[
        const TextWidget.body1(
          "\$12.10",
          size: 18,
          weight: FontWeight.bold,
        ).paddingRight(
          AppSpace.listItem,
        ),
        // 说明:
        const TextWidget.body2(
          "by paperfly shipment",
        )
      ].toRow(),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .paddingVertical(
          AppSpace.page,
        );
  }

  _buildTitle(String title) {
    return TextWidget.body1(title).paddingBottom(AppSpace.listRow);
  }
}
