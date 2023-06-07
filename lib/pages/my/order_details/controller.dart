import 'package:get/get.dart';

import '../../../common/index.dart';

class OrderDetailsController extends GetxController {
  // 订单详情:
  final OrderModel order = Get.arguments as OrderModel;

  OrderDetailsController();

  _initData() {
    update(["order_details"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
