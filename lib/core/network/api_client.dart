// lib/core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});
  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});
  Future<Response> delete(String path,
      {dynamic data, Map<String, dynamic>? queryParameters});

  Future<void> setAuthToken(String token);
  void clearAuthToken();
  String get currentBaseUrl;
  void updateBaseUrl(String newBaseUrl);
  void resetInterceptors();
  void setLogging(bool enabled);
}

class DioApiClient implements ApiClient {
  late final Dio _dio;
  String _baseUrl = '';

  static final DioApiClient _instance = DioApiClient._();
  factory DioApiClient() => _instance;

  DioApiClient._() {
    _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: Duration(
          milliseconds: int.parse(dotenv.env['CONNECT_TIMEOUT'] ?? '5000'),
        ),
        receiveTimeout: Duration(
          milliseconds: int.parse(dotenv.env['RECEIVE_TIMEOUT'] ?? '3000'),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
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
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(_handleDioError(e));
        },
      ),
    ]);
  }

  DioException _handleDioError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Anslutningen tog för lång tid';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Timeout vid skickande av data';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Timeout vid mottagande av data';
        break;
      case DioExceptionType.badResponse:
        message = _getErrorMessageFromStatus(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        message = 'Förfrågan avbröts';
        break;
      case DioExceptionType.connectionError:
        message =
            'Kunde inte ansluta till servern. Kontrollera din internetanslutning.';
        break;
      case DioExceptionType.badCertificate:
        message = 'Säkerhetsfel: Ogiltigt certifikat';
        break;
      case DioExceptionType.unknown:
      default:
        message = error.error?.toString() ?? 'Ett oväntat fel inträffade';
        break;
    }
    return DioException(
      requestOptions: error.requestOptions,
      error: message,
      response: error.response,
      type: error.type,
    );
  }

  String _getErrorMessageFromStatus(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Felaktig förfrågan';
      case 401:
        return 'Behörighet saknas';
      case 403:
        return 'Åtkomst nekad';
      case 404:
        return 'Resursen kunde inte hittas';
      case 409:
        return 'Konflikt med existerande data';
      case 422:
        return 'Ogiltig data skickades';
      case 500:
        return 'Internt serverfel';
      case 503:
        return 'Tjänsten är inte tillgänglig';
      default:
        return 'Ett fel uppstod (${statusCode ?? "okänd statuskod"})';
    }
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'Ett oväntat fel inträffade: $e',
      );
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'Ett oväntat fel inträffade: $e',
      );
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'Ett oväntat fel inträffade: $e',
      );
    }
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'Ett oväntat fel inträffade: $e',
      );
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
  String get currentBaseUrl => _baseUrl;

  @override
  void updateBaseUrl(String newBaseUrl) {
    _baseUrl = newBaseUrl;
    _dio.options.baseUrl = newBaseUrl;
  }

  @override
  void resetInterceptors() {
    _dio.interceptors.clear();
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

  // Utvecklarhjälpmetoder
  void clearInterceptors() {
    _dio.interceptors.clear();
  }

  bool get hasAuthToken => _dio.options.headers.containsKey('Authorization');

  Map<String, dynamic> get currentHeaders =>
      Map<String, dynamic>.from(_dio.options.headers);

  Duration get currentConnectTimeout =>
      _dio.options.connectTimeout ?? const Duration(milliseconds: 5000);

  Duration get currentReceiveTimeout =>
      _dio.options.receiveTimeout ?? const Duration(milliseconds: 3000);
}
