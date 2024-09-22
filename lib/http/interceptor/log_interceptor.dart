// 日志打印拦截器
import 'dart:convert';

import 'package:dio/dio.dart';

class LoggerInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("request start ------------>");
    options.headers.forEach((key, value) {
      print("请求头信息 $key : ${value.toString()} \n");
    });
    print("请求地址: ${options.uri}, 请求方法: ${options.method}");
    try {
      print("data: ${jsonEncode(options.data)}");
    } catch (e) {
      print("data: ${options.data}");
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("statusCode:${response.statusCode}");
    print('响应数据：${response.data}');
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    print("\nonError-------------->");
    print("error:${error.toString()}");
    print("<--------------onError\n");
    super.onError(error, handler);
  }
}
