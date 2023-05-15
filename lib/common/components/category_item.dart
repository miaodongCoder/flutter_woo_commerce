import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';

class CategoryListItemWidget extends StatelessWidget {
  // 分类数据:
  final CategoryModel categoryModel;
  // 选中代码:
  final int? selectedId;
  // tap 点击事件:
  final Function(int categoryId)? onTap;

  const CategoryListItemWidget({
    super.key,
    required this.categoryModel,
    this.selectedId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 图片:
      ImageWidget.url(
        categoryModel.image?.src ?? "",
        width: 52.w,
        height: 52.w,
      ),
      // 文字:
      TextWidget.body1(
        categoryModel.name ?? "",
        size: 16.sp,
        color: selectedId == categoryModel.id ? AppColors.onSecondary : null,
      ),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
        )
        .paddingVertical(AppSpace.button)
        .backgroundColor(selectedId == categoryModel.id ? AppColors.onSurfaceVariant : Colors.transparent)
        .onTap(() {
      if (onTap == null) return;
      if (categoryModel.id == null) return;
      onTap!(categoryModel.id!);
    });
  }
}
