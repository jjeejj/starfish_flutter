import 'package:dio/dio.dart';

import 'http_merhod.dart';
import 'interceptor/log_interceptor.dart';
import 'interceptor/resp_interceptor.dart';
import 'interceptor/token_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  static DioInstance instance() {
    return _instance ??= DioInstance._internal();
  }

  final Dio _dio = Dio();

  // 默认没有初始化实例
  var _inited = false;

  // 默认的时间
  final _defaultTimeout = const Duration(seconds: 10);

  // 内部实例化
  DioInstance._internal() {
    // 添加拦截器
    _dio.interceptors.add(LogInterceptor());
    _inited = true;
  }

  // 外部初始化
  void init({
    required String baseUrl,
    String? method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    String? contentType = Headers.jsonContentType,
    ResponseType? responseType = ResponseType.json,
  }) {
    _dio.options = _buildBaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      contentType: contentType ?? Headers.jsonContentType,
      responseType: responseType ?? ResponseType.json,
    );
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(RespInterceptor());
    _dio.interceptors.add(LoggerInterceptor());
  }

// 构建 baseOptions
  BaseOptions _buildBaseOptions({
    required String baseUrl,
    String? method = HttpMethod.GET,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    String? contentType = Headers.jsonContentType,
    ResponseType? responseType = ResponseType.json,
  }) {
    return BaseOptions(
      baseUrl: baseUrl,
      method: method,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      contentType: contentType,
      responseType: responseType,
    );
  }

  // 更改 baseURl
  void changeBaseUrl(String baseUrl) async {
    _dio.options.baseUrl = baseUrl;
  }

  // get 请求
  Future<Response> get(
      {required String path,
      Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    if (!_inited) {
      throw Exception('请先初始化 dio');
    }
    return await _dio.get(path,
        options: options ??
            Options(
              method: HttpMethod.GET,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            ),
        queryParameters: params,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  // get 请求
  Future<Response> post(
      {required String path,
      Object? data,
      Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    if (!_inited) {
      throw Exception('请先初始化 dio');
    }
    return await _dio.post(path,
        options: options ??
            Options(
              method: HttpMethod.POST,
              receiveTimeout: _defaultTimeout,
              sendTimeout: _defaultTimeout,
            ),
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}
