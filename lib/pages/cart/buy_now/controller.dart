import 'package:get/get.dart';

import '../../../common/index.dart';

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
  // 折扣
  double get discount => 0;
  // 商品合计价格
  double get totalPrice => double.parse(productModel.price!) * quantity;

  _initData() {
    shippingAddress = UserService.to.shipping;
    update(["buy_now"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // 下单 checkout
  void onCheckout() async {}

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
}
