import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

/// slider indicator 指示器:
class SliderIndicatorWidget extends StatelessWidget {
  /// 个数:
  final int length;
  final int currentIndex;
  final Color color;
  final bool isCircle;
  final MainAxisAlignment alignment;

  SliderIndicatorWidget({
    super.key,
    required this.length,
    required this.currentIndex,
    Color? color,
    bool? isCircle,
    MainAxisAlignment? alignment,
  })  : color = color ?? AppColors.primary,
        isCircle = isCircle ?? false,
        alignment = alignment ?? MainAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          // 圆形宽度6, 否则当前位置15, 其他位置8:
          width: !isCircle
              ? currentIndex == index
                  ? 15
                  : 8
              : 6,
          // 圆形高度6, 否则4:
          height: !isCircle ? 4 : 6,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
            color: currentIndex == index ? color : color.withOpacity(.3),
          ),
        );
      }),
    );
  }
}
