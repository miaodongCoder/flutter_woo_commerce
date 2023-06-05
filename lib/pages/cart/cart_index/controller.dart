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
}
