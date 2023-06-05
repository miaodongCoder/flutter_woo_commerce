import 'package:get/get.dart';

import '../../../common/index.dart';

class CartIndexController extends GetxController {
  // 优惠券代码:
  String couponCode = '';
  // 商品是否选中:
  List<int> selectedIds = [];

  CartIndexController();

  _initData() {
    update(["cart_index"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // 是否全选:
  bool get isSelectedAll =>
      CartService.to.lineItems.isEmpty ? false : CartService.to.lineItems.length == selectedIds.length;

  // 是否选中:
  bool isSelected(int productId) {
    return selectedIds.any((val) => val == productId);
  }

  // 全选:
  void onSelectAll(bool isSelected) {
    if (isSelected) {
      // 全选
      selectedIds = CartService.to.lineItems.map((item) => item.productId!).toList();
    } else {
      // 全不选
      selectedIds.clear();
    }
    update(["cart_index"]);
  }

  // 选中:
  void onSelect(int productId, bool isSelected) {
    if (isSelected) {
      // 全选
      selectedIds.add(productId);
    } else {
      // 全不选
      selectedIds.remove(productId);
    }
    update(["cart_index"]);
  }

  // 删除购物车订单:
  Future<void> onOrderCancel() async {
    for (var i = 0; i < selectedIds.length; i++) {
      int productId = selectedIds[i];
      CartService.to.deleteItemByProductId(productId);
    }

    selectedIds.clear();
    update(["cart_index"]);
  }

  // 应用优惠码:`568935ab`
  Future<void> onApplyCoupon() async {
    if (couponCode.isEmpty) {
      Loading.error("优惠码为空~");
      return;
    }

    CouponsModel? coupon = await CouponApi.couponsDetail(couponCode);
    if (coupon == null) {
      Loading.error("无效的优惠码!");
      return;
    }

    couponCode = '';
    // 使用优惠券:
    bool isSuccess = CartService.to.applyCoupon(coupon);
    if (isSuccess) {
      Loading.success("优惠码使用成功!");
    } else {
      Loading.error("优惠码已经被使用过啦~");
    }
    update(['cart_index']);
  }

// 修改订单数量:
  Future<void> onChangeQuantity(LineItem lineItem, int quantity) async {
    CartService.to.changeQuantity(lineItem.productId ?? 0, quantity);
    update(['cart_index']);
  }
}
