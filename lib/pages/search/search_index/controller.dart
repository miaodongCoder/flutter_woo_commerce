import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import '../../../common/models/request/product.dart';

class SearchIndexController extends GetxController {
  // 搜索控制器:
  final TextEditingController searchEditingController = TextEditingController();
  final searchKeyWord = "".obs;
  List<TagsModel> tagsList = [];

  SearchIndexController();

  _initData() {
    searchDebounce();
    update(["search_index"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();

    searchEditingController.dispose();
  }

  // 搜索栏位 - 防抖:
  void searchDebounce() {
    // getx 内置防抖处理
    debounce(
      // obs 对象:
      searchKeyWord,
      // 回调函数:
      (value) async {
        await _loadSearch(value);
        // 拉取数据:
        update(["search_index"]);
      },
      // 延迟 500 毫秒:
      time: const Duration(milliseconds: 500),
    );
    // 监听搜索框变化:
    searchEditingController.addListener(() {
      searchKeyWord.value = searchEditingController.text;
    });
  }

  Future<bool> _loadSearch(String keyword) async {
    if (keyword.trim().isEmpty == true) {
      tagsList.clear();
      return tagsList.isEmpty;
    }

    // 拉取数据:
    var result = await ProductApi.tags(TagsReq(search: keyword));
    tagsList.clear();
    if (result.isNotEmpty) {
      tagsList.addAll(result);
    }
    return tagsList.isEmpty;
  }

  // 列表项点击:
  void onListItemTap(TagsModel model) {
    if (model.name == null) return;
    searchEditingController.text = model.name!;
  }
}
