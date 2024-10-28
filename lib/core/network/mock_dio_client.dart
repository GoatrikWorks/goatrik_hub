import 'package:dio/dio.dart';

import 'api_client.dart';

class MockDioClient implements ApiClient {
  String _currentBaseUrl = 'http://mock-api.local';
  String? _authToken;
  bool _isLoggingEnabled = false;
  final Map<String, dynamic> _mockResponses = {
    '/auth/login': {
      'user': {
        'id': '1',
        'email': 'test@example.com',
        'name': 'Test User',
        'createdAt': DateTime.now().toIso8601String(),
        'isPremium': false,
        'profileImage': null,
      },
      'token': 'mock-token',
    },
    '/activities': [
      {
        'id': '1',
        'title': 'Mock Activity 1',
        'description': 'This is a mock activity',
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'pending',
        'type': 'task',
      },
    ],
  };

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    await Future.delayed(
        const Duration(milliseconds: 100)); // Simulate network delay

    if (_mockResponses.containsKey(path)) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _mockResponses[path],
      );
    }

    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 404,
      data: {'message': 'Not Found'},
    );
  }

  @override
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (path == '/auth/login') {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 200,
        data: _mockResponses['/auth/login'],
      );
    }

    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 201,
      data: {'message': 'Created', 'data': data},
    );
  }

  @override
  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: {'message': 'Updated', 'data': data},
    );
  }

  @override
  Future<Response> delete(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Response(
      requestOptions: RequestOptions(path: path),
      statusCode: 204,
    );
  }

  @override
  void clearAuthToken() {
    _authToken = null;
  }

  @override
  String get currentBaseUrl => _currentBaseUrl;

  @override
  void resetInterceptors() {
    // No-op for mock client
  }

  @override
  Future<void> setAuthToken(String token) async {
    _authToken = token;
  }

  @override
  void setLogging(bool enabled) {
    _isLoggingEnabled = enabled;
  }

  @override
  void updateBaseUrl(String newBaseUrl) {
    _currentBaseUrl = newBaseUrl;
  }

  // Helper methods for testing
  String? get authToken => _authToken;
  bool get isLoggingEnabled => _isLoggingEnabled;

  void addMockResponse(String path, dynamic data) {
    _mockResponses[path] = data;
  }

  void clearMockResponses() {
    _mockResponses.clear();
  }
}
