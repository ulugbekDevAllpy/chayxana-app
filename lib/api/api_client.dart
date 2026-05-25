import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';
import 'api_exception.dart';

class ApiClient {
  ApiClient._() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: ApiConfig.defaultHeaders,
      validateStatus: (status) => status != null && status < 500,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth.token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) => handler.next(e),
    ));
  }

  static final ApiClient instance = ApiClient._();
  late final Dio _dio;

  bool get isConfigured => ApiConfig.baseUrl.isNotEmpty;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    if (!isConfigured) {
      throw ApiException(message: 'API not configured', endpoint: path);
    }
    try {
      final res = await _dio.get(path, queryParameters: query);
      return _unwrap(res, path);
    } on DioException catch (e) {
      throw _toApiException(e, path);
    }
  }

  Future<dynamic> post(String path, {Object? body}) async {
    if (!isConfigured) {
      throw ApiException(message: 'API not configured', endpoint: path);
    }
    try {
      final res = await _dio.post(path, data: body);
      return _unwrap(res, path);
    } on DioException catch (e) {
      throw _toApiException(e, path);
    }
  }

  Future<dynamic> put(String path, {Object? body}) async {
    if (!isConfigured) {
      throw ApiException(message: 'API not configured', endpoint: path);
    }
    try {
      final res = await _dio.put(path, data: body);
      return _unwrap(res, path);
    } on DioException catch (e) {
      throw _toApiException(e, path);
    }
  }

  Future<dynamic> delete(String path) async {
    if (!isConfigured) {
      throw ApiException(message: 'API not configured', endpoint: path);
    }
    try {
      final res = await _dio.delete(path);
      return _unwrap(res, path);
    } on DioException catch (e) {
      throw _toApiException(e, path);
    }
  }

  dynamic _unwrap(Response res, String path) {
    if (res.statusCode != null && res.statusCode! >= 400) {
      throw ApiException(
        message: res.statusMessage ?? 'Request failed',
        statusCode: res.statusCode,
        endpoint: path,
      );
    }
    return res.data;
  }

  ApiException _toApiException(DioException e, String path) {
    return ApiException(
      message: e.message ?? 'Network error',
      statusCode: e.response?.statusCode,
      endpoint: path,
    );
  }
}
