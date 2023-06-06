import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/index.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel item;
  const OrderListItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  // 主视图:
  Widget _buildView() {
    return <Widget>[
      // id tag
      <Widget>[
        // 编号
        TextWidget.body1("# ${item.id}").expanded(),

        // 标签tag
        _buildTag(item.status ?? "-"),
      ].toRow().paddingBottom(AppSpace.listRow),

      // orderKey date
      <Widget>[
        // 订单号
        TextWidget.body1("${item.orderKey}").expanded(),

        // 日期
        TextWidget.body2("${item.dateCreated}".dateFormatOfyyyyMMdd),
      ].toRow(),
    ].toColumn().paddingAll(AppSpace.card).card();
  }

  Widget _buildTag(String tag) {
    return ButtonWidget.primary(
      tag,
    ).tight(
      width: 100.w,
      height: 32.w,
    );
  }
}
