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
}
