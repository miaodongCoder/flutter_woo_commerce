import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

/// 价格区间组件:
class PriceRangeWidget extends StatelessWidget {
  // 当前值:
  final List<double>? values;
  // 拖动事件:
  final Function(int handlerIndex, dynamic lowerValue, dynamic upperValue)?
      onDragging;
  // 最大值:
  final double? max;
  // 最小值:
  final double? min;

  const PriceRangeWidget({
    super.key,
    this.values,
    this.onDragging,
    this.max = 99999,
    this.min = 0,
  });

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      <Widget>[
        TextWidget.body3("\$${values?[0]}"),
        const Spacer(),
        TextWidget.body3("\$${values?[1]}"),
      ].toRow(),
      FlutterSlider(
        values: values ?? [],
        rangeSlider: true,
        max: max,
        min: min,
        handlerHeight: 6,
        handlerWidth: 6,
        trackBar: FlutterSliderTrackBar(
          activeTrackBar: BoxDecoration(
            color: AppColors.highlight,
          ),
          inactiveTrackBar: BoxDecoration(
            color: AppColors.outline,
          ),
        ),
        // 提示:
        tooltip: FlutterSliderTooltip(
          leftPrefix: const IconWidget.icon(
            Icons.attach_money,
          ),
          rightPrefix: const IconWidget.icon(
            Icons.attach_money,
          ),
        ),
        // 左侧滑块:
        handler: FlutterSliderHandler(
          decoration: const BoxDecoration(),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.highlight,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
              border: Border.all(
                color: AppColors.highlight,
                width: 1,
              ),
            ),
          ),
        ),
        // 右侧滑块:
        rightHandler: FlutterSliderHandler(
          decoration: const BoxDecoration(),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.highlight,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
              border: Border.all(
                color: AppColors.highlight,
                width: 1,
              ),
            ),
          ),
        ),
        onDragging: onDragging,
      ),
    ].toColumn();
  }
}
