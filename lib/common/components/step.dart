import 'package:flutter/material.dart';

import '../index.dart';

/// 状态枚举
enum StepStatus {
  none,
  running,
  success,
}

///横向滚动组件
class StepHorizontalItemWidget extends StatelessWidget {
  /// 状态名称
  final String statusName;

  /// 状态
  final StepStatus status;

  const StepHorizontalItemWidget({
    Key? key,
    required this.statusName,
    this.status = StepStatus.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return <Widget>[
          // 指示标
          <Widget>[
            // 左右都是灰色线条:
            if (status == StepStatus.none)
              Container(
                color: AppColors.surfaceVariant.withOpacity(0.5),
                height: 3,
              ),
            // 左右都是蓝色线条:
            if (status == StepStatus.success)
              Container(
                color: AppColors.primary,
                height: 3,
              ),
            // 左边蓝色线条:
            if (status == StepStatus.running)
              Container(
                color: AppColors.primary,
                height: 3,
                width: constraints.minWidth / 2,
              ).alignLeft(),
            // 右边灰色线条:
            if (status == StepStatus.running)
              Container(
                color: AppColors.surfaceVariant.withOpacity(0.5),
                height: 3,
                width: constraints.minWidth / 2,
              ).alignRight(),
            // 圆点
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                color: status == StepStatus.none ? AppColors.surfaceVariant.withOpacity(0.5) : AppColors.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(7 / 2),
                ),
              ),
            ),
          ]
              .toStack(
                alignment: Alignment.center,
              )
              .paddingBottom(AppSpace.iconTextSmail),

          // 文字
          TextWidget.body3(
            statusName,
          ),
        ].toColumn();
      },
    ).expanded();
  }
}
