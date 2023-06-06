import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class ApplyPromoCodePage extends GetView<ApplyPromoCodeController> {
  // 应用优惠券
  final Function(String) onApplyCouponCode;
  const ApplyPromoCodePage({
    super.key,
    required this.onApplyCouponCode,
  });

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 标题
      TextWidget.title3(LocaleKeys.promoCode.tr).paddingBottom(AppSpace.listRow),

      // 说明
      TextWidget.body2(
        LocaleKeys.promoDesc.tr,
        maxLines: 3,
        softWrap: true,
      ).paddingBottom(AppSpace.listRow),

      // 输入优惠券
      InputWidget.textBorder(
        controller: controller.couponController,
        hintText: "Enter your coupon code",
      ).paddingBottom(AppSpace.listRow),

      // 按钮
      _buildButtons(),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .paddingAll(40)
        .backgroundColor(AppColors.background);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyPromoCodeController>(
      init: ApplyPromoCodeController(),
      id: "apply_promo_code",
      builder: (_) {
        return _buildView();
      },
    );
  }

  // 底部按钮
  Widget _buildButtons() {
    return <Widget>[
      // cancel
      ButtonWidget.text(
        LocaleKeys.commonBottomCancel.tr,
        onTap: () => Get.back(),
      ).decorated().tight(width: 120.w, height: 44.w),
      SizedBox(
        width: AppSpace.button,
      ),
      // apply
      ButtonWidget.text(
        LocaleKeys.commonBottomApply.tr,
        // 确认优惠券输入
        onTap: () {
          // 回调函数
          onApplyCouponCode(controller.couponController.text);
          Get.back();
        },
        textColor: AppColors.onPrimary,
        textWeight: FontWeight.w500,
      )
          .decorated(
            border: Border.all(
              color: AppColors.highlight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.button),
            color: AppColors.highlight,
          )
          .expanded(),
    ].toRow(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
