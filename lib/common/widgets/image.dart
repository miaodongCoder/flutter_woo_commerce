import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

enum ImageWidgetType {
  asset,
  network,
  file,
}

/// 图片组件:
class ImageWidget extends StatelessWidget {
  final String url;
  final ImageWidgetType type;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Color? backgroundColor;
  // build回调函数:
  final Widget Function(BuildContext context, ImageProvider provider,
      Widget completed, Size? size)? builder;

  const ImageWidget({
    super.key,
    required this.url,
    required this.type,
    this.radius,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.backgroundColor,
    this.builder,
  });

  const ImageWidget.url(
    this.url, {
    super.key,
    this.type = ImageWidgetType.network,
    this.radius,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.backgroundColor,
    this.builder,
  });

  const ImageWidget.asset(
    this.url, {
    super.key,
    this.type = ImageWidgetType.asset,
    this.radius,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.backgroundColor,
    this.builder,
  });

  const ImageWidget.file(
    this.url, {
    super.key,
    this.type = ImageWidgetType.file,
    this.radius,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.backgroundColor,
    this.builder,
  });

  Widget get _placeholder {
    return placeholder ??
        const IconWidget.image(
          AssetsImage.defaultPng,
          size: 36,
        );
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(
      radius ?? AppRadius.image,
    ));

    Widget? image;
    switch (type) {
      case ImageWidgetType.asset:
        image = ExtendedImage.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          loadStateChanged: (state) => _buildLoadStateChanged(context, state),
        );
        break;
      case ImageWidgetType.network:
        if (!url.contains('http')) break;
        image = ExtendedImage.network(
          url,
          width: width,
          height: height,
          fit: fit,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          loadStateChanged: (state) => _buildLoadStateChanged(context, state),
        );
        break;
      case ImageWidgetType.file:
        if (!url.contains('http')) break;
        image = ExtendedImage.file(
          File(url),
          width: width,
          height: height,
          fit: fit,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius,
          loadStateChanged: (state) => _buildLoadStateChanged(context, state),
        );
        break;
      default:
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: image ?? _placeholder,
    );
  }

  // 实时的回调当前图片加载的状态:
  Widget _buildLoadStateChanged(
      BuildContext context, ExtendedImageState state) {
    switch (state.extendedImageLoadState) {
      // 读取中:
      case LoadState.loading:
        return _placeholder;
      // 读取成功:
      case LoadState.completed:
        {
          Size? size;
          if (state.extendedImageInfo != null) {
            size = Size(
              state.extendedImageInfo!.image.width.toDouble(),
              state.extendedImageInfo!.image.height.toDouble(),
            );
          }
          final imageProvider = state.imageProvider;
          final completedWidget = state.completedWidget;
          return builder?.call(context, imageProvider, completedWidget, size) ??
              completedWidget;
        }
      case LoadState.failed:
        return const Center(
          child: Icon(
            CupertinoIcons.info_circle,
            size: 20,
            color: Colors.grey,
          ),
        );
      default:
        return _placeholder;
    }
  }
}
