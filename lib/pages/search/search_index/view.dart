import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';

class SearchIndexPage extends GetView<SearchIndexController> {
  const SearchIndexPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return _buildList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchIndexController>(
      init: SearchIndexController(),
      id: "search_index",
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: InputWidget.textBorder(
        controller: controller.searchEditingController,
        hintText: LocaleKeys.commonSearchInput.tr,
        onChanged: (text) {
          debugPrint(text);
        },
      ).paddingRight(AppSpace.paragraph),
    );
  }

  // 列表:
  Widget _buildList() {
    return ListView.separated(
      itemBuilder: (context, index) => _buildListItem(controller.tagsList[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: controller.tagsList.length,
    );
  }

  // 列表项:
  Widget _buildListItem(TagsModel item) {
    return ListTile(
      title: TextWidget.body1(
        item.name ?? "",
      ),
      trailing: IconWidget.icon(
        Icons.north_west,
        color: AppColors.primary,
      ),
      onTap: () => controller.onListItemClicked(item),
    );
  }
}
