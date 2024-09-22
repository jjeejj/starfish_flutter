// 返回值拦截器

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';

import '../response_model.dart';

// RespInterceptor 响应值拦截器处理
class RespInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == HttpStatus.ok) {
      try {
        var respData = ResponseModel.fromJson(response.data);
        if (respData.code == null) {
          handler.reject(DioException(requestOptions: response.requestOptions));
        } else {
          if (respData.code == 200) {
            handler.next(Response(
                requestOptions: response.requestOptions,
                data: respData.content));
          } else if (respData.code == 210 &&
              response.requestOptions.path.contains("getAppInfo") == false) {
            handler
                .reject(DioException(requestOptions: response.requestOptions));
            showToast(respData.message ?? "系统错误");
          } else {
            //其他错误
            if (response.requestOptions.path.contains("getAppInfo") == false) {
              showToast(respData.message ?? "系统错误");
            }
            handler
                .reject(DioException(requestOptions: response.requestOptions));
          }
        }
      } catch (e) {
        handler.reject(DioException(requestOptions: response.requestOptions));
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}
