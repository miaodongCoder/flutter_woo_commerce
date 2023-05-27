import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:flutter_woo_commerce/common/models/woo/review_model/review_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../index.dart';

/// 商品评论
class TabReviewsView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabReviewsView({Key? key, required this.uniqueTag}) : super(key: key);

  @override
  String? get tag => uniqueTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProductDetailsController(),
      tag: tag,
      id: "product_reviews",
      builder: (controller) {
        return SmartRefresher(
          // 刷新控制器
          controller: controller.reviewsRefreshController,
          // 启用上拉加载
          enablePullUp: true,
          // 下拉刷新回调
          onRefresh: controller.onReviewsRefresh,
          // 上拉加载回调
          onLoading: controller.onReviewsLoading,
          // 底部加载更多
          footer: const SmartRefresherFooterWidget(),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return _buildListItem(
                controller.reviews.elementAt(index),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: AppSpace.listItem * 2,
              );
            },
            itemCount: controller.reviews.length,
          ),
        );
      },
    );
  }

  Widget _buildListItem(ReviewModel item) {
    return <Widget>[
      // 头像:
      const ImageWidget.url(
        // item.reviewerAvatarUrls?["96"],
        // 测试需要改成自定义头像
        "https://ducafecat.oss-cn-beijing.aliyuncs.com/avatar/00258VC3ly1gty0r05zh2j60ut0u0tce02.jpg",
        width: 55,
        height: 55,
      ).paddingRight(AppSpace.listItem),
      // 星星、名称、评论、图:
      <Widget>[
        // 名称、时间:
        <Widget>[
          TextWidget.title3(
            item.reviewer ?? "",
          ),
          // 时间:
          TextWidget.body2(
            DateTime.parse(item.dateCreated ?? "")
                .toDateString(format: 'yyyy .MM .dd'),
          ),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),

        // 评论:
        TextWidget.body1(
          item.review?.clearHtml ?? "",
        ),
        // 图:
        _buildReviewImages(),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).expanded(),
    ].toRow(crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildReviewImages() {
    return <Widget>[
      for (String imageUrl in controller.reviewImages)
        ImageWidget.url(
          imageUrl,
          width: 45.w,
          height: 45.w,
        )
            .paddingRight(
              AppSpace.listItem,
            )
            .onTap(
              () => controller.onReviewsGalleryTap(
                controller.reviewImages.indexOf(imageUrl),
              ),
            ),
    ].toWrap(
      spacing: AppSpace.listItem,
      runSpacing: AppSpace.listItem,
    );
  }
}
