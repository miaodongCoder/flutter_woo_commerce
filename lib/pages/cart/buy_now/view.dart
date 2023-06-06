import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class BuyNowPage extends GetView<BuyNowController> {
  final ProductModel productModel;
  const BuyNowPage({
    super.key,
    required this.productModel,
  });

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 支付方式:
      _buildTitle(LocaleKeys.placeOrderPayment.tr),
      _buildPayment(),
      // 送货地址:
      _buildTitle(LocaleKeys.placeOrderShippingAddress.tr),
      _buildShipping(),
      // 数量:
      _buildTitle(LocaleKeys.placeOrderQuantity.tr),
      // 小计:
      _buildTitle(LocaleKeys.placeOrderPrice.tr),
      // 按钮:
      _buildButtons(),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .paddingAll(AppSpace.page)
        .backgroundColor(AppColors.background);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowController>(
      init: BuyNowController(productModel),
      id: "buy_now",
      builder: (_) {
        return _buildView();
      },
    );
  }

  Widget _buildTitle(String text) {
    return TextWidget.title2(text).paddingBottom(AppSpace.listRow);
  }

  Widget _buildPayment() {
    return List.generate(controller.paymentList.length, (index) {
      return ImageWidget.asset(
        controller.paymentList[index],
        width: 106.w,
        height: 50.w,
        backgroundColor: AppColors.surface,
      )
          .decorated(
            border: Border.all(
              color: AppColors.surfaceVariant,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(AppRadius.button),
          )
          .paddingRight(AppSpace.iconTextSmail);
    }).toListView(scrollDirection: Axis.horizontal).height(50.w).paddingBottom(AppSpace.listRow);
  }

  Widget _buildButtons() {
    return <Widget>[
      // 取消:
      ButtonWidget.secondary(
        LocaleKeys.commonBottomCancel.tr,
        onTap: () => Get.back(),
      ).expanded(),
      // 间距:
      SizedBox(
        width: AppSpace.iconTextLarge,
      ),
      // 立即购买:
      ButtonWidget.primary(
        LocaleKeys.placeOrderBtnPlaceOrder.tr,
        onTap: controller.onCheckout,
      ).expanded(),
    ]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingHorizontal(AppSpace.page);
  }

  // 送货地址
  Widget _buildShipping() {
    return <Widget>[
      // 文字:
      TextWidget.body1(controller.shippingAddress).expanded(),
      // 图标:
      const IconWidget.icon(
        Icons.arrow_drop_down,
        size: 32,
      ),
    ]
        .toRow()
        .paddingAll(AppSpace.button)
        .decorated(
          color: AppColors.surfaceVariant,
          border: Border.all(
            color: AppColors.outline,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.button),
        )
        .onTap(controller.onShippingTap)
        .paddingBottom(AppSpace.listRow);
  }
}
