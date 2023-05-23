import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

/// 图标文字组件: ( ★ 4.5 ❤️ 100 + )
class IconTextWidget extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final IconData? iconData;
  final double? iconSize;
  final double? fontSize;
  final Color? color;
  final double? iconPadding;

  const IconTextWidget({
    super.key,
    this.icon,
    this.text,
    this.iconData,
    this.iconSize,
    this.fontSize,
    this.color,
    this.iconPadding,
  });

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 图标:
      icon?.paddingRight(iconPadding ?? AppSpace.iconTextSmail) ??
          IconWidget.icon(
            iconData ?? Icons.star,
            size: iconSize ?? 12,
            color: color ?? AppColors.primary,
          ).paddingRight(
            iconPadding ?? AppSpace.iconTextSmail,
          ),
      // 文字:
      TextWidget.body2(
        text ?? '',
        size: fontSize ?? 12,
      ),
    ].toRow(mainAxisSize: MainAxisSize.min).fittedBox(
          fit: BoxFit.none,
          clipBehavior: Clip.hardEdge,
        );
  }
}
