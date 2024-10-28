import 'package:dio/dio.dart';

import '../config/env.dart';
import 'api_client.dart';

class DioClient implements ApiClient {
  late final Dio _dio;
  String _currentBaseUrl = Env.apiUrl;

  // Singleton pattern
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _currentBaseUrl,
        connectTimeout: Duration(milliseconds: Env.connectTimeout),
        receiveTimeout: Duration(milliseconds: Env.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token or other headers here
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    ]);
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Response> delete(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> setAuthToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  String get currentBaseUrl => _currentBaseUrl;

  @override
  void updateBaseUrl(String newBaseUrl) {
    _currentBaseUrl = newBaseUrl;
    _dio.options.baseUrl = newBaseUrl;
  }

  @override
  void resetInterceptors() {
    _setupInterceptors();
  }

  @override
  void setLogging(bool enabled) {
    if (enabled) {
      if (!_dio.interceptors.any((i) => i is LogInterceptor)) {
        _dio.interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ));
      }
    } else {
      _dio.interceptors.removeWhere((i) => i is LogInterceptor);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Anslutningstid slutade');
      case DioExceptionType.sendTimeout:
        return Exception('Skickningstid slutade');
      case DioExceptionType.receiveTimeout:
        return Exception('Mottagningstid slutade');
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response?.statusCode);
      case DioExceptionType.cancel:
        return Exception('Förfrågan avbröts');
      case DioExceptionType.connectionError:
        return Exception(
            'Kunde inte ansluta till servern. Kontrollera din internetanslutning.');
      case DioExceptionType.badCertificate:
        return Exception('Säkerhetsfel: Ogiltigt certifikat');
      case DioExceptionType.unknown:
        return Exception('Ett oväntat fel inträffade');
      default:
        return Exception('Något gick fel');
    }
  }

  Exception _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return Exception('Felaktig förfrågan');
      case 401:
        return Exception('Ej behörig');
      case 403:
        return Exception('Åtkomst nekad');
      case 404:
        return Exception('Resursen hittades inte');
      case 500:
        return Exception('Internt serverfel');
      default:
        return Exception('Ett fel uppstod: ${statusCode ?? "Okänd statuskod"}');
    }
  }
}
