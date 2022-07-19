import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'dio_helper.dart';
import 'interceptors/app_interceptor.dart';

typedef RequestQueryCallback = Future<Map<String, dynamic>> Function();
typedef RequestHeaderCallback = Future<Map<String, dynamic>> Function();
typedef ResponseCallback = Future<void> Function(Response);
typedef ErrorCallback = Future<void> Function(DioError);

class DioImpl extends DioHelper {
  final RequestHeaderCallback? onRequestHeader;
  final RequestQueryCallback? onRequestQueryPrams;
  final ResponseCallback? onResponseCallback;
  final ErrorCallback? onErrorCallback;
  final String baseURL;
  late Dio _client;

  DioImpl({
    required this.baseURL,
    this.onResponseCallback,
    this.onRequestHeader,
    this.onRequestQueryPrams,
    this.onErrorCallback,
  }) {
    _client = Dio()
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
          ),
        AppInterceptors(
          onRequestHeader,
          onRequestQueryPrams,
          onResponseCallback,
          onErrorCallback,
        ),
      ])
      ..options.baseUrl = baseURL
      ..options.headers.addAll({'Accept': 'application/json'});
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _client.get(
      url,
      queryParameters: queryParams,
      options: options,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _client.post(
      url,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _client.put(
      url,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) {
    return _client.delete(
      url,
      data: data,
      queryParameters: queryParams,
      options: options,
    );
  }
}
