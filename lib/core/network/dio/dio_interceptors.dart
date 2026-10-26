import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/core/storage/local_storage.dart';

class DioInterceptors extends Interceptor {
  DioInterceptors({
    this.getToken,
    required this.localStorage,
    required this.baseUrl,
  });

  final Future<String?> Function()? getToken;
  final LocalStorage localStorage;
  final String baseUrl;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await getToken?.call();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      options.headers['Accept-Language'] = localStorage.getLocale();

      if (kDebugMode) {
        debugPrint('[NETWORK][REQUEST] ${options.method} ${options.path}');
      }
    } catch (e) {
      debugPrint('[NETWORK][REQUEST][ERROR] $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[NETWORK][RESPONSE] ${response.statusCode} ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('[NETWORK][ERROR] ${err.type} ${err.message}');
    }
    super.onError(err, handler);
  }
}
