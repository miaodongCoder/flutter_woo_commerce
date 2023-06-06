import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import '../../index.dart';

class BuyNowController extends GetxController {
  // 商品详情:
  ProductModel productModel;

  BuyNowController(this.productModel);
  // 支付方式图标
  List<String> paymentList = [
    AssetsImage.pVisaPng,
    AssetsImage.pCashPng,
    AssetsImage.pMastercardPng,
    AssetsImage.pPaypalPng,
  ];

  // 送货地址:
  String shippingAddress = "";

  // 数量
  int quantity = 1;
  // 运费
  double get shipping => 0;
  // 折扣:
  double get discount => lineCoupons.fold<double>(0, (double previousValue, CouponsModel element) {
        return previousValue + (double.parse(element.amount ?? "0"));
      });
  // 商品合计价格
  double get totalPrice => double.parse(productModel.price!) * quantity;

  // 优惠券列表
  final List<CouponsModel> lineCoupons = [];

  _initData() {
    shippingAddress = UserService.to.shipping;
    update(["buy_now"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // 下单 checkout:
  void onCheckout() async {
    // 商品 LineItem:
    List<LineItem> lineItems = [
      LineItem(
        productId: productModel.id,
        quantity: quantity,
      ),
    ];

    // 提交订单:
    OrderModel res = await OrderApi.crateOrder(
      lineItem: lineItems,
      lineCoupons: lineCoupons,
    );

    // 交易成功:
    if (res.id != null) {
      // 提示
      Loading.success("Order created.");

      // goto 成功界面: offNamed 会把弹窗关掉的~
      Get.offNamed(RouteNames.cartBuyDone, arguments: res);
    }
  }

  // 修改送货地址:
  Future<void> onShippingTap() async {
    var result = await Get.toNamed(RouteNames.myMyAddress, arguments: {"type": "Shipping"});
    if (result != null && result == true) {
      shippingAddress = UserService.to.shipping;
      update(["buy_now"]);
    }
  }

  // 修改数量:
  void onQuantityChange(int value) {
    quantity = value;
    update(["buy_now"]);
  }

// 显示输入优惠券 `568935ab`:
  void onEnterCouponCode() {
    ActionBottomSheet.popModal(
      child: ApplyPromoCodePage(
        onApplyCouponCode: (couponCode) async {
          // 判断优惠券是否存在
          if (couponCode.isEmpty) {
            Loading.error("Voucher code empty.");
            return;
          }
          CouponsModel? coupon = await CouponApi.couponsDetail(couponCode);
          if (coupon != null) {
            couponCode = "";
            bool isSuccess = _applyCoupon(coupon);
            if (isSuccess) {
              Loading.success("Coupon applied.");
            } else {
              Loading.error("Coupon is already applied.");
            }
            update(["buy_now"]);
          } else {
            Loading.error("Coupon code is not valid.");
          }
        },
      ),
      safeAreaMinimum: EdgeInsets.fromLTRB(50.w, 0, 50.w, 140.w),
    );
  }

  // 使用优惠券:
  bool _applyCoupon(CouponsModel item) {
    // 是否有重复
    int index = lineCoupons.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      return false;
    }
    // 添加
    lineCoupons.add(item);
    return true;
  }
}
