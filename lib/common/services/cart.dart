import 'package:get/get.dart';

import '../index.dart';

/// 购物车服务:
class CartService extends GetxService {
  static CartService get to => Get.find<CartService>();

  /// 购物车商品:
  final List<LineItem> lineItems = RxList<LineItem>();

  /// 优惠券列表:
  final List<CouponsModel> lineCoupons = [];

  /// 使用优惠券:
  bool applyCoupon(CouponsModel item) {
    // 是否有重复的优惠券:
    int index = lineCoupons.indexWhere((element) => element.id == item.id);
    if (index >= 0) return false;

    lineCoupons.add(item);
    return true;
  }

  /// 加入商品到购物车中:
  void addToCart(LineItem item) {
    // 检查是否已经存在于购物车中:
    int index = lineItems.indexWhere((element) => element.productId == item.productId);
    // 已存在 , 更新商品数量:
    if (index >= 0) {
      // 重新赋值 , 直接把购物车列表里的这件商品的数量 + 1计算:
      // 入参的item 就是指购物车列表里的同productId 的item!
      item = lineItems[index];
      // 已经存在 , 更新数量:
      item.quantity = item.quantity ?? 1 + 1;
      item.price = int.parse(item.product?.price ?? "0");
      item.total = (item.price! * item.quantity!).toString();
    } else {
      // 不存在 , 添加新商品:
      item.quantity = 1;
      item.price = int.parse(item.product?.price ?? "0");
      item.total = (item.price! * item.quantity!).toString();
      lineItems.add(item);
    }
  }

  /// 删除商品:
  void deleteItemByProductId(int productId) {
    lineItems.removeWhere((element) => element.productId == productId);
  }

  /// 修改商品数量:
  void changeQuantity(int productId, int quantity) {
    // 小于0 等于删除:
    if (quantity <= 0) {
      deleteItemByProductId(productId);
    }

    // 设置商品数量:
    LineItem item = lineItems.firstWhere((element) => element.productId == productId);
    item.quantity = quantity;
    item.price = int.parse(item.product?.price ?? "0");
    item.total = (item.price! * item.quantity!).toString();
  }

  /// 清空购物车:
  void get clear => lineItems.clear();

  /// 商品数量:
  int get lineItemsCount => lineItems.length;

  /// 运费:
  double get shipping => 0;

  /// 折扣:
  double get discount => lineCoupons.fold(
        0,
        (previousValue, element) => previousValue + (double.parse(element.amount ?? "0")),
      );

  /// 商品合计价格:
  double get totalItemPrice => lineItems.fold(
        0,
        (previousValue, element) =>
            previousValue +
            int.parse(
              element.total ?? "0",
            ),
      );
}
