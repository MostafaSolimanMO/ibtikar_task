import 'package:dio/dio.dart';

abstract class DioHelper {
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    Options? options,
  });

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  });

  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  });

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  });
}
