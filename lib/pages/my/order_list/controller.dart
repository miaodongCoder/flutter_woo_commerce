import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderListController extends GetxController {
  // 刷新控制器:
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  // 数据源数组:
  List<OrderModel> items = [];
  // 页码:
  int _page = 1;
  // 页尺寸:
  final int _limit = 20;

  OrderListController();

  _initData() {
    update(["order_list"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();

    _loadSearch(true);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  // 拉取数据:
  // isRefresh 是否是下拉刷新:
  Future<bool> _loadSearch(bool isRefresh) async {
    OrderReq req = OrderReq(page: isRefresh ? 1 : _page, prePage: _limit);
    // 拉取数据:
    List<OrderModel> result = await OrderApi.getOrderLists(req);
    // 下拉刷新:
    if (isRefresh) {
      // 重置页码:
      _page = 1;
      // 清空数据源:
      items.clear();
    }

    // 有数据:
    if (result.isNotEmpty) {
      // _page++并不影响本次的数据 , 是为了让下一次请求的页码自动 ++ !
      _page++;
      items.addAll(result);
    }

    return result.isEmpty;
  }

  // 上拉加载更多新的订单数据:
  void onLoading() async {
    if (items.isNotEmpty) {
      try {
        // 拉取下一页的数据:
        var isEmpty = await _loadSearch(false);
        // 如果下一页数据为空:
        if (isEmpty) {
          // 没有更多数据:
          refreshController.loadNoData();
        } else {
          // 加载完成:
          refreshController.loadComplete();
        }
      } catch (e) {
        refreshController.loadFailed();
      }
    } else {
      // 没有更多数据:
      refreshController.loadNoData();
    }
    update(["order_list"]);
  }

  void onRefresh() async {
    try {
      await _loadSearch(true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.loadFailed();
    }
    update(["order_list"]);
  }

  // 点击item进入订单详情:
  void onOrderItemTap(OrderModel order) {}
}
