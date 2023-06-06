import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 优惠码控制器:
class ApplyPromoCodeController extends GetxController {
  // 优惠券控制器
  TextEditingController couponController = TextEditingController();

  ApplyPromoCodeController();

  _initData() {
    update(["apply_promo_code"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    couponController.dispose();
  }
}
