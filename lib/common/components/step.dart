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

class StepVerticalItemWidget extends StatelessWidget {
  // 状态名称:
  final String statusName;
  // 状态描述:
  final String? statusDes;
  // 状态时间:
  final String? statusDateTime;
  // 状态:
  final StepStatus status;

  const StepVerticalItemWidget({
    super.key,
    required this.statusName,
    this.statusDes,
    this.statusDateTime,
    this.status = StepStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return <Widget>[
          // 日期:
          TextWidget.body1(statusDateTime ?? "-").paddingRight(AppSpace.listItem),
          // 指示器:
          <Widget>[
            // 上下都是灰色线条:
            if (status == StepStatus.none)
              Container(
                width: 3,
                height: constraints.maxHeight,
                color: AppColors.surfaceVariant.withOpacity(.5),
              ),
            // 上下都是蓝色线条:
            if (status == StepStatus.success)
              Container(
                width: 3,
                height: constraints.maxHeight,
                color: AppColors.primary,
              ),
            // 下边蓝色线条:
            if (status == StepStatus.running)
              Container(
                color: AppColors.primary,
                width: 3,
                height: constraints.maxHeight * 2 / 3,
              ).alignBottom(),
            // 上边灰色线条:
            if (status == StepStatus.running)
              Container(
                color: AppColors.surfaceVariant.withOpacity(0.5),
                width: 3,
                height: constraints.maxHeight / 3,
              ).alignTop(),
            // 圆点:
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: status == StepStatus.none ? AppColors.surfaceVariant.withOpacity(.5) : AppColors.primary,
                borderRadius: BorderRadius.circular(7 / 2),
              ),
            ).align(const Alignment(0.0, -1 / 3)),
          ].toStack(alignment: Alignment.center).paddingRight(AppSpace.listItem),
          // 说明:
          <Widget>[
            TextWidget.title3(statusName),
            TextWidget.body2(
              statusDes ?? "-",
              softWrap: true,
              maxLines: 3,
            ),
          ]
              .toColumn(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
              .expanded(),
        ].toRow();
      },
    ).constrained(maxHeight: 70);
  }
}
