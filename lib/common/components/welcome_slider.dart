import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../index.dart';

class WelcomeSliderWidget extends StatelessWidget {
  final List<WelcomeModel> items;
  // 页数发生变化:
  final Function(int index) onPageChanged;
  final CarouselController? carouselController;
  const WelcomeSliderWidget(
    this.items, {
    super.key,
    required this.onPageChanged,
    this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: 500.w,
        // 充满:
        viewportFraction: 1,
        // 动画,封面效果:
        enlargeCenterPage: false,
        // 无限循环:
        enableInfiniteScroll: false,
        // 自动播放:
        autoPlay: false,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
      items: <Widget>[
        for (WelcomeModel item in items) _sliderItem(item),
      ],
    );
  }

  Widget _sliderItem(WelcomeModel item) {
    return Builder(
      builder: (context) {
        return <Widget>[
          if (item.image != null)
            ImageWidget.asset(
              item.image!,
              fit: BoxFit.cover,
            ),
          if (item.title != null)
            TextWidget.title1(
              item.title ?? "",
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          if (item.desc != null)
            TextWidget.body1(
              item.desc ?? "",
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
        ]
            .toColumn(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            )
            .width(
              MediaQuery.of(context).size.width,
            );
      },
    );
  }
}
