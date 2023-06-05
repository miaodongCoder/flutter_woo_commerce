import 'package:flutter/cupertino.dart';

import '../index.dart';

/// 数量编辑
class QuantityWidget extends StatelessWidget {
  // 数量发送改变
  final Function(int quantity) onChange;
  // 数量
  final int quantity;
  // 尺寸
  final double? size;
  // 文字尺寸
  final double? fontSize;
  // padding 水平距离
  final double? paddingHorizontal;
  // 颜色
  final Color? color;

  QuantityWidget({
    Key? key,
    required this.quantity,
    required this.onChange,
    this.size,
    this.fontSize,
    this.paddingHorizontal,
    Color? color,
  })  : color = color ?? AppColors.onSurfaceVariant,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 减号:
      // 超过一个数量才允许显示可点击的删除按钮:
      if (quantity > 1)
        ButtonWidget.icon(
          Icon(
            CupertinoIcons.minus,
            size: fontSize ?? 14,
            color: color,
          ),
          onTap: () => onChange(quantity - 1),
        ),
      // 只有一个不允许再删除:
      if (quantity == 1)
        ButtonWidget.icon(
          Icon(
            CupertinoIcons.minus,
            size: fontSize ?? 14,
            color: AppColors.surfaceVariant,
          ),
          onTap: null,
        ),

      // 数量:
      TextWidget.body2(
        "$quantity",
        color: color,
      )
          .center()
          .tight(width: size ?? 24, height: size ?? 24)
          .decorated(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: color!, width: 1),
          )
          .paddingHorizontal(paddingHorizontal ?? AppSpace.iconTextSmail),

      // 加号
      ButtonWidget.icon(
        Icon(
          CupertinoIcons.plus,
          size: fontSize ?? 14,
          color: AppColors.highlight,
        ),
        onTap: () => onChange(quantity + 1),
      ),
    ].toRow();
  }
}
