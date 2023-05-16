import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';

class PlaceholderWidget extends StatelessWidget {
  final String? assetImagePath;
  const PlaceholderWidget({
    super.key,
    this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ImageWidget.asset(
      assetImagePath ?? AssetsImage.homePlaceholderPng,
    ).paddingHorizontal(AppSpace.page).center();
  }
}
