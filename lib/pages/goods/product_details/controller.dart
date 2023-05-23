import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  ProductDetailsController();

  int productId = Get.arguments['id'] ?? 0;
  ProductModel? productModel;
  List<KeyValueModel> bannerItems = [];
  int bannerCurrentIndex = 0;

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  _initData() async {
    await _loadProduct();
    update(["product_details"]);
  }

  _loadProduct() async {
    productModel = await ProductApi.productDetail(productId);
    if (productModel == null) return;
    if (productModel?.images != null) {
      bannerItems = productModel!.images!
          .map((image) => KeyValueModel(
                key: image.id.toString(),
                value: image.src,
              ))
          .toList();
    }
  }

  void onChangeBannner(int index, CarouselPageChangedReason reason) {
    bannerCurrentIndex = index;
    update(["product_banner"]);
  }

  void onGalleryTap(int index, KeyValueModel item) {
    Get.to(GalleryWidget(
      initialIndex: index,
      items: bannerItems.map<String>((KeyValueModel model) => model.value).toList(),
    ));
  }
}
