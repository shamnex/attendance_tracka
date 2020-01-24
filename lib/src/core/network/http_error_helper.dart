import 'package:dio/dio.dart';

mixin DioErrorHelper {
  String handleDioError(DioError e) {
    switch (e.type) {
      case DioErrorType.DEFAULT:
        return "No Internet";
      case DioErrorType.CONNECT_TIMEOUT:
        return "Connection timeout";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "Connection timeout";
      case DioErrorType.RESPONSE:
        return e.response.data['message'];
      default:
        return "Connection Error";
    }
  }
}
