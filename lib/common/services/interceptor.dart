import 'package:dio/dio.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart' hide Response;

/// 拦截
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // http header 头加入 Authorization:
    if (UserService.to.hasToken) {
      options.headers['Authorization'] = 'Bearer ${UserService.to.token}';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 200 请求成功, 201 添加成功
    if (response.statusCode != 200 && response.statusCode != 201) {
      handler.reject(
        DioError(
          requestOptions: response.requestOptions,
          response: response,
          type: DioErrorType.badResponse,
        ),
        true,
      );
    } else {
      handler.next(response);
    }
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      // 服务端自定义错误体处理

      case DioErrorType.badResponse:
        {
          final response = err.response;
          final errorMessage = ErrorMessageModel.fromJson(response?.data);
          switch (errorMessage.statusCode) {
            // 已存在使用此电子邮件地址的帐户，请登录:
            case 400:
              break;
            // 401 未登录:
            case 401:
              // 注销 并跳转到登录页面:
              _errorNoAuthLogout();
              break;
            case 404:
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
          Loading.error(errorMessage.message);
        }
        break;
      case DioErrorType.unknown:
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionTimeout:
        break;
      default:
        break;
    }

    handler.next(err);
  }

  /// 退出并重新登录:
  Future<void> _errorNoAuthLogout() async {
    await UserService.to.logout();
    Get.toNamed(RouteNames.systemLogin);
  }
}
