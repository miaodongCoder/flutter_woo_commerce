import 'package:flutter_woo_commerce/common/index.dart';

/// 用户 Api:
class UserApi {
  static Future<bool> register(UserRegisterReq? req) async {
    var result = await WPHttpService.to.post(
      '/users/register',
      data: req,
    );

    if (result.statusCode == 201) return true;
    return false;
  }

  static Future<UserTokenModel> login(UserLoginReq? req) async {
    var result = await WPHttpService.to.post(
      '/users/login',
      data: req,
    );

    return UserTokenModel.fromJson(result.data);
  }

  /// Profile

  static Future<UserProfileModel> profile() async {
    var result = await WPHttpService.to.post(
      '/users/me',
    );

    return UserProfileModel.fromJson(result.data);
  }
}
