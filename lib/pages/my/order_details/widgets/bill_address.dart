import 'package:flutter/material.dart';

import '../../../../common/index.dart';

/// 订单地址项:
class BuildBillAddress extends StatelessWidget {
  const BuildBillAddress({
    Key? key,
    this.title,
    this.address,
    this.city,
    this.state,
    this.country,
    this.phone,
  }) : super(key: key);

  final String? title, address, city, state, country, phone;

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return <Widget>[
      // title:
      TextWidget.title3(title ?? "").paddingBottom(AppSpace.listItem),

      // address:
      IconTextWidget(
        icon: const IconWidget.icon(
          Icons.storefront,
          size: 15,
        ),
        text: address,
      ).paddingBottom(AppSpace.listItem),

      // address, city, state, country:
      IconTextWidget(
        icon: const IconWidget.icon(
          Icons.location_on_outlined,
          size: 15,
        ),
        text: "$city, $state, $country",
      ).paddingBottom(AppSpace.listItem),

      // phone:
      IconTextWidget(
        icon: const IconWidget.icon(
          Icons.phone_in_talk,
          size: 15,
        ),
        text: phone,
      ),
    ].toColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
