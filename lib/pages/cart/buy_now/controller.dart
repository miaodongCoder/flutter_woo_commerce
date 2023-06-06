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

  _initData() {
    update(["buy_now"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // 下单 checkout
  void onCheckout() async {}
}
