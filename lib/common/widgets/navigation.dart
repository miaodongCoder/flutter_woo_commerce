import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

class NavigationItemModel {
  final String label;
  final String icon;
  final int count;
  NavigationItemModel({
    required this.label,
    required this.icon,
    this.count = 0,
  });
}

class BuildNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavigationItemModel> items;
  final Function(int index) onTap;
  const BuildNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> ws = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      Color? color = (i == currentIndex) ? AppColors.primary : null;
      NavigationItemModel item = items.elementAt(i);
      ws.add(
        <Widget>[
          // 图标:
          IconWidget.svg(
            item.icon,
            size: 20,
            color: color,
            badgeString: item.count > 0 ? '${item.count}' : null,
          ).paddingBottom(2),
          // 文字:
          TextWidget.body1(
            item.label.tr,
            color: color,
          ),
        ]
            .toColumn(
              mainAxisAlignment: MainAxisAlignment.center, // 居中
              mainAxisSize: MainAxisSize.max, // 撑满
            )
            .onTap(() => onTap(i))
            .expanded(),
      );

      // mainAxisSize: MainAxisSize.max, // 撑满
      // mainAxisAlignment: MainAxisAlignment.center, // 居中
      // onTap 中已经是 behavior: behavior ?? HitTestBehavior.opaque, 防事件穿透
    }

    return BottomAppBar(
      color: AppColors.surface,
      child: ws
          .toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
          .height(kBottomNavigationBarHeight),
    );
  }
}
