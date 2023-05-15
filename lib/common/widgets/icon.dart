// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:badges/badges.dart';

enum IconWidgetType {
  icon,
  svg,
  image,
  url,
}

class IconWidget extends StatelessWidget {
  final IconWidgetType type;
  final IconData? iconData;
  final String? assetName;
  final String? imageUrl;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isDot;
  final String? badgeString;
  final BoxFit? fit;

  const IconWidget({
    super.key,
    required this.type,
    this.iconData,
    this.assetName,
    this.imageUrl,
    this.size,
    this.width,
    this.height,
    this.color,
    this.isDot,
    this.badgeString,
    this.fit,
  });

  const IconWidget.icon(
    this.iconData, {
    super.key,
    this.type = IconWidgetType.icon,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.isDot,
    this.badgeString,
    this.assetName,
    this.imageUrl,
    this.fit,
  });

  const IconWidget.image(
    this.assetName, {
    super.key,
    this.type = IconWidgetType.image,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.isDot,
    this.badgeString,
    this.imageUrl,
    this.fit,
  });

  const IconWidget.svg(
    this.assetName, {
    super.key,
    this.type = IconWidgetType.svg,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.isDot,
    this.badgeString,
    this.imageUrl,
    this.fit,
  });

  const IconWidget.url(
    this.imageUrl, {
    super.key,
    this.type = IconWidgetType.url,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.isDot,
    this.badgeString,
    this.iconData,
    this.assetName,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    switch (type) {
      case IconWidgetType.icon:
        icon = Icon(
          iconData,
          size: size,
          color: color ?? AppColors.primary,
        );
        break;
      case IconWidgetType.svg:
        icon = SvgPicture.asset(
          assetName ?? "",
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      case IconWidgetType.image:
        icon = Image.asset(
          assetName ?? "",
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      case IconWidgetType.url:
        icon = Image.network(
          imageUrl ?? "",
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      default:
        return const SizedBox();
    }
    // 圆点:
    if (isDot == true) {
      return Badge(
        position: BadgePosition.topEnd(top: 0, end: -7),
        badgeStyle: BadgeStyle(
          elevation: 0,
          badgeColor: AppColors.primary,
          padding: const EdgeInsets.all(4.0),
        ),
        child: icon,
      );
    }

    // 文字、数字:
    if (badgeString != null) {
      return Badge(
        badgeContent: Text(
          badgeString ?? "",
          style: TextStyle(
            color: AppColors.onPrimary,
            fontSize: 9,
          ),
        ),
        position: BadgePosition.topEnd(top: -7, end: -8),
        badgeStyle: BadgeStyle(
          elevation: 0,
          badgeColor: AppColors.primary,
          padding: const EdgeInsets.all(4.0),
        ),
        child: icon,
      );
    }

    return icon;
  }
}
