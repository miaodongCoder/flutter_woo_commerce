import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return SingleChildScrollView(
      child: <Widget>[
        // 标题:
        _buildTitle(),
        // 横向状态:
        _buildHorizontalStatus(),
        // 纵向状态:
        _buildVerticalStatus(),
        // 寄件地、目的地:
        _buildBillAddress(),
        // 商品列表:
        _buildProductsList(),
        // 小计:
        _buildTotal(),
        // 底部间距:
        const SizedBox(height: 100),
      ].toColumn(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      id: "order_details",
      builder: (_) {
        return Scaffold(
          appBar: mainAppBarWidget(titleString: LocaleKeys.orderDetailsTitle.tr),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  // 标题:
  Widget _buildTitle() {
    return <Widget>[
      // Order ID:
      TextWidget.title3("${LocaleKeys.orderDetailsOrderID.tr} : ${controller.order.id}").expanded(),
      // 15 Jan 2019:
      TextWidget.body2("${controller.order.dateCreated?.dateFormatOfyyyyMMdd}"),
    ].toRow().padding(
          top: AppSpace.page,
          bottom: AppSpace.listRow,
          left: AppSpace.page,
          right: AppSpace.page,
        );
  }

  // 横向状态
  Widget _buildHorizontalStatus() {
    return <Widget>[
      const StepHorizontalItemWidget(
        statusName: "Pending",
        status: StepStatus.success,
      ),
      const StepHorizontalItemWidget(
        statusName: "Confirmed",
        status: StepStatus.success,
      ),
      const StepHorizontalItemWidget(
        statusName: "Processing",
        status: StepStatus.running,
      ),
      const StepHorizontalItemWidget(
        statusName: "Picked",
        status: StepStatus.none,
      ),
      const StepHorizontalItemWidget(
        statusName: "Shipped",
        status: StepStatus.none,
      ),
      const StepHorizontalItemWidget(
        statusName: "Delivered",
        status: StepStatus.none,
      ),
    ].toRow().padding(
          bottom: AppSpace.listRow,
          left: AppSpace.page,
          right: AppSpace.page,
        );
  }

  // 纵向状态:
  Widget _buildVerticalStatus() {
    return const Text("纵向状态");
  }

  // 寄件地、目的地:
  Widget _buildBillAddress() {
    return const Text("寄件地、目的地");
  }

  // 商品列表:
  Widget _buildProductsList() {
    return const Text("商品列表");
  }

  // 小计:
  Widget _buildTotal() {
    return const Text("小计");
  }
}
