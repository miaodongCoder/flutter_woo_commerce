import '../index.dart';

class CouponApi {
  /// 优惠券详情:
  static Future<CouponsModel?> couponsDetail(String code) async {
    var res = await WPHttpService.to.get(
      '/coupons',
      params: {
        "code": code,
      },
    );

    List<CouponsModel> coupons = [];
    for (Map<String, dynamic> item in res.data) {
      coupons.add(CouponsModel.fromJson(item));
    }

    return coupons.isNotEmpty ? coupons.first : null;
  }
}
