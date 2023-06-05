import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

/// 购物车列表项:
class CartItem extends StatelessWidget {
  // 订单数据:
  final LineItem lineItem;
  // 修改数量事件:
  final Function(int value)? onChangeQuantity;
  // 选中事件:
  final Function(bool value)? onSelected;
  // 是否全选:
  final bool isSelected;

  const CartItem({
    super.key,
    required this.lineItem,
    required this.isSelected,
    this.onChangeQuantity,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartIndexController(),
      id: "goods_${lineItem.productId}",
      builder: (controller) {
        return _buildView();
      },
    );
  }

  Widget _buildView() {
    ProductModel productModel =
        lineItem.product ?? ProductModel(id: 000, name: "空白商品数据");
    return <Widget>[
      // 1.单选框:
      CheckBoxWidget.all(
        isSelected,
        onSelected,
        fontColor: AppColors.primary,
        bgColorChecked: AppColors.primaryContainer,
        size: 20.sp,
      ).paddingRight(AppSpace.iconTextSmail),
      // 2.图片:
      ImageWidget.url(
        Convert.aliImageResize(
          productModel.images?.first.src ?? "",
          width: 100.w,
        ),
        fit: BoxFit.cover,
        width: 78.w,
        height: 100.w,
        radius: AppRadius.image.w,
      ).paddingRight(AppSpace.iconTextMedium),
      // 3.标题、数量、金额:
      <Widget>[
        TextWidget.title3(
          productModel.name ?? "",
        ).paddingBottom(AppSpace.listRow),
        if (productModel.attributes?.isNotEmpty == true)
          TextWidget.body2(
            "${productModel.attributes?.first.name} - ${productModel.attributes?.first.options} ",
          ),

        // 属性 Size
        if (productModel.attributes?.length == 2)
          TextWidget.body2(
            "${productModel.attributes?[1].name} - ${productModel.attributes?[1].options} ",
          ),
        // 金额 + 数量:
        <Widget>[
          // 金额:
          TextWidget.body2(
            "\$ ${lineItem.total}",
            weight: FontWeight.bold,
          ).expanded(),
          // 数量:
        ].toRow().paddingTop(AppSpace.listRow),

        // end
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
          .expanded(),
    ].toRow(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
