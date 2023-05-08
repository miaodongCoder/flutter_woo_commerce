import 'package:dio/dio.dart';
import 'package:flutter_woo_commerce/common/index.dart';
import 'package:get/get.dart' hide Response;

/// 拦截
class RequestInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // super.onRequest(options, handler);
    // if (UserService.to.hasToken) {
    //   options.headers['Authorization'] = 'Bearer ${UserService.to.token}';
    // }
    return handler.next(options);
    // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
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

  /// 退出并重新登录
  Future<void> _errorNoAuthLogout() async {
    // await UserService.to.logout();
    Get.toNamed(RouteNames.systemLogin);
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
            case 401:
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
}
