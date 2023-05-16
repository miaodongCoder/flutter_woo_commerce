import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

AppBar mainAppBarWidget({
  Key? key,
  Function()? onTap,
  Widget? leading,
  String? hintText,
  String? titleString,
  double? titleSpace,
  double? iconSize,
}) {
  return AppBar(
    leading: leading,
    titleSpacing: titleSpace ?? AppSpace.listItem,
    title: hintText != null
        ? InputWidget.textBorder(
            hintText: hintText,
            readOnly: true,
            onTap: onTap,
          )
        : Text(titleString ?? ""),
    actions: [
      // 搜索:
      IconWidget.svg(
        AssetsSvgs.iSearchSvg,
        size: iconSize ?? 20,
      ).paddingRight(AppSpace.listItem),
      // 消息:
      IconWidget.svg(
        AssetsSvgs.iNotificationsSvg,
        size: iconSize ?? 20,
        isDot: true,
      ).paddingRight(AppSpace.listItem).unconstrained(),
      // 更多:
      IconWidget.svg(
        AssetsSvgs.iIndicatorsSvg,
        size: iconSize ?? 20,
      ).paddingRight(AppSpace.listItem),
    ],
  );
}
