import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import '../index.dart';

class FilterView extends GetView<SearchFilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchFilterController>(
      id: "filter_view",
      builder: (_) {
        return _buildView();
      },
    );
  }

  Widget _buildView() {
    return <Widget>[
      // 顶部
      _buildTopBar(),
      // 价格选择:
      _buildTitle(LocaleKeys.searchFilterPrice.tr),
      _buildPriceRange(),
      // 尺寸选择:
      _buildTitle(LocaleKeys.searchFilterSize.tr),
      _buildSizes(),
      // 颜色选择:
      _buildTitle(LocaleKeys.searchFilterColor.tr),
      _buildColors(),
      // 打分、评级选择:
      _buildTitle(LocaleKeys.searchFilterReview.tr),
      _buildStars(),
      // 品牌
      _buildTitle(LocaleKeys.searchFilterBrand.tr),
      _buildBrands(),
      // 性别
      _buildTitle(LocaleKeys.searchFilterGender.tr),
      _buildGenders(),
      // 新旧
      _buildTitle(LocaleKeys.searchFilterCondition.tr),
      _buildConditions(),
      const Divider(),
      ButtonWidget.primary(
        LocaleKeys.commonBottomApply.tr,
        height: AppSpace.buttonHeight,
        onTap: controller.onFilterApplyTap,
      ),
    ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .paddingHorizontal(AppSpace.page);
  }

  // 顶部 关闭
  Widget _buildTopBar() {
    return <Widget>[
      // 文字:
      TextWidget.title3(LocaleKeys.searchFilter.tr),
      // 关闭按钮:
      ButtonWidget.icon(
        IconWidget.icon(
          Icons.close,
          size: 15,
          color: AppColors.secondary,
        ),
        onTap: controller.onFilterCloseTap,
      )
    ]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .paddingBottom(AppSpace.listRow);
  }

  Widget _buildTitle(String title) {
    return TextWidget.body2(title).paddingBottom(AppSpace.listItem);
  }

  Widget _buildPriceRange() {
    return GetBuilder(
      init: SearchFilterController(),
      id: "filter_price_range",
      builder: (controller) {
        return PriceRangeWidget(
          max: 5000,
          min: 0,
          values: controller.priceRange,
          onDragging: controller.onPriceRangeDragging,
        ).paddingBottom(AppSpace.listItem);
      },
    );
  }

  // 尺寸选择组件:
  Widget _buildSizes() {
    return GetBuilder(
      init: SearchFilterController(),
      id: "filter_sizes",
      builder: (controller) {
        return TagsListWidget(
          itemList: controller.sizes,
          keys: controller.sizeKeys,
          onTap: controller.onSizeTap,
          bgSelectedColor: AppColors.highlight,
          textSelectedColor: AppColors.onPrimary,
          isCircular: true,
          size: 24,
          textSize: 9,
          textWeight: FontWeight.w400,
        ).paddingBottom(AppSpace.listItem * 2);
      },
    );
  }

  // 颜色选择组件:
  Widget _buildColors() {
    return GetBuilder(
      init: SearchFilterController(),
      id: "filter_colors",
      builder: (controller) {
        return ColorsListWidget(
          itemList: controller.colors,
          keys: controller.colorKeys,
          onTap: controller.onColorTap,
          size: 24,
        ).paddingBottom(AppSpace.listItem * 2);
      },
    );
  }

  Widget _buildStars() {
    return GetBuilder(
      init: SearchFilterController(),
      id: "filter_stars",
      builder: (controller) {
        return StarsListWidget(
          value: controller.starValue,
          onTap: controller.onStarTap,
          selectedColor: AppColors.highlight,
          size: 18,
        ).paddingBottom(AppSpace.listItem * 2);
      },
    );
  }

  // 品牌选择
  Widget _buildBrands() {
    return GetBuilder<SearchFilterController>(
      id: "filter_brands",
      builder: (controller) {
        return TagsListWidget(
          onTap: controller.onBrandTap,
          itemList: controller.brands,
          keys: controller.brandKeys,
          bgSelectedColor: AppColors.highlight,
          textSelectedColor: AppColors.onPrimary,
          borderRadius: 11,
          height: 17,
          width: 55,
          textSize: 9,
          textWeight: FontWeight.w400,
        ).paddingBottom(AppSpace.listRow * 2);
      },
    );
  }

  // 性别选择
  Widget _buildGenders() {
    return GetBuilder<SearchFilterController>(
      id: "filter_genders",
      builder: (controller) {
        return TagsListWidget(
          onTap: controller.onGenderTap,
          itemList: controller.genders,
          keys: controller.genderKeys,
          bgSelectedColor: AppColors.highlight,
          textSelectedColor: AppColors.onPrimary,
          borderRadius: 11,
          height: 17,
          width: 55,
          textSize: 9,
          textWeight: FontWeight.w400,
        ).paddingBottom(AppSpace.listRow * 2);
      },
    );
  }

  // 新旧选择
  Widget _buildConditions() {
    return GetBuilder<SearchFilterController>(
      id: "filter_conditions",
      builder: (controller) {
        return TagsListWidget(
          onTap: controller.onConditionTap,
          itemList: controller.conditions,
          keys: controller.conditionKeys,
          bgSelectedColor: AppColors.highlight,
          textSelectedColor: AppColors.onPrimary,
          borderRadius: 11,
          height: 17,
          width: 55,
          textSize: 9,
          textWeight: FontWeight.w400,
        ).paddingBottom(AppSpace.listRow * 2);
      },
    );
  }
}
