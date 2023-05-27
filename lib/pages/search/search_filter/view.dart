import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class SearchFilterPage extends GetView<SearchFilterController> {
  const SearchFilterPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 筛选栏
      _buildFilterBar(),
      // 数据列表
      _buildListView(),
    ].toColumn();
  }

  // 搜索过滤栏:
  Widget _buildFilterBar() {
    return const Text("搜索过滤栏");
  }

  // 数据列表:
  Widget _buildListView() {
    return const Text("数据列表");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchFilterController>(
      init: SearchFilterController(),
      id: "search_filter",
      builder: (_) {
        return Scaffold(
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
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
