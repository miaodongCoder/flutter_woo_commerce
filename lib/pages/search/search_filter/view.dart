import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'index.dart';

class SearchFilterPage extends GetView<SearchFilterController> {
  const SearchFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchFilterController>(
      init: SearchFilterController(),
      id: "search_filter",
      builder: (_) {
        return Scaffold(
          // Key:
          key: controller.scaffoldKey,
          // 导航:
          appBar: mainAppBarWidget(
            leading: ButtonWidget.icon(
              IconWidget.icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
              onTap: controller.back,
            ),
            hintText: LocaleKeys.searchPlaceholder.tr,
            onTap: controller.back,
          ),
          // 内容:
          body: SafeArea(
            child: _buildView(),
          ),
          // 右侧弹出过滤消息盒子:
          endDrawer: const Drawer(
            child: SafeArea(child: FilterView()),
          ),
        );
      },
    );
  }

  // 主视图:
  Widget _buildView() {
    return <Widget>[
      // 筛选栏
      _buildFilterBar(),
      SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        footer: const SmartRefresherFooterWidget(),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildListView().sliverPaddingHorizontal(AppSpace.button),
          ],
        ),
      ).expanded(),
    ].toColumn();
  }

  // 搜索过滤栏:
  Widget _buildFilterBar() {
    return <Widget>[
      // 排序 Best Match
      DropdownWidget(
        items: controller.orderList,
        hintText: controller.orderSelected.value,
        onChanged: controller.onOrderTap,
      )
          .decorated(
            border: Border.all(
              color: AppColors.surfaceVariant,
              width: 1,
            ),
          )
          .height(40.h)
          .expanded(),

      // 筛选 Filter
      ButtonWidget.dropdown(
        LocaleKeys.searchFilter.tr,
        IconWidget.icon(
          Icons.expand_more,
          color: AppColors.primary,
        ),
        onTap: controller.onFilterOpenTap,
        textSize: 15,
        textColor: AppColors.secondary,
        textWeight: FontWeight.w400,
        borderColor: AppColors.surfaceVariant,
        height: 40.h,
      ).expanded(),
    ].toRow();
  }

  // 数据列表
  Widget _buildListView() {
    return GetBuilder<SearchFilterController>(
      id: "filter_products",
      builder: (_) {
        return controller.items.isEmpty
            ?
            // 占位图
            const PlaceholderWidget().sliverBox
            :
            // 商品列表:
            SliverGrid.builder(
                itemCount: controller.items.length, // 数据长度
                itemBuilder: (context, index) {
                  var product = controller.items[index]; // 商品项数据
                  // 商品项组件
                  return ProductItemWidget(
                    product, // 商品
                    imgHeight: 117.w, // 图片高度
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 每行3个
                  mainAxisSpacing: AppSpace.listRow, // 主轴间距
                  crossAxisSpacing: AppSpace.listItem, // 交叉轴间距
                  childAspectRatio: 0.7, // 宽高比
                ),
              );
      },
    );
  }
}
