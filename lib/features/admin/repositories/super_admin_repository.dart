import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../auth/models/user.dart';
import '../../home/enums/user_role.dart';
import '../models/admin_settings.dart';

class SuperAdminRepository {
  final ApiClient _apiClient;

  SuperAdminRepository({ApiClient? apiClient})
      : _apiClient = apiClient ?? DioApiClient();

  Future<List<User>> getAllUsers() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.users);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not fetch users');
    }
  }

  Future<User> updateUserRole(String userId, UserRole newRole) async {
    try {
      final response = await _apiClient.put(
        '${ApiEndpoints.users}/$userId/role',
        data: {'role': newRole.toString()},
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Failed to update user role');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not update user role');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final response = await _apiClient.delete('${ApiEndpoints.users}/$userId');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete user');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not delete user');
    }
  }

  Future<AdminSettings> getSettings() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.adminSettings);

      if (response.statusCode == 200) {
        return AdminSettings.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch admin settings');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not fetch admin settings');
    }
  }

  Future<AdminSettings> updateSettings(AdminSettings settings) async {
    try {
      final response = await _apiClient.put(
        ApiEndpoints.adminSettings,
        data: settings.toJson(),
      );

      if (response.statusCode == 200) {
        return AdminSettings.fromJson(response.data);
      } else {
        throw Exception('Failed to update admin settings');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not update admin settings');
    }
  }

  Future<List<Map<String, dynamic>>> getAdminLogs({
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    String? action,
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEndpoints.adminLogs,
        queryParameters: {
          if (startDate != null) 'startDate': startDate.toIso8601String(),
          if (endDate != null) 'endDate': endDate.toIso8601String(),
          if (userId != null) 'userId': userId,
          if (action != null) 'action': action,
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch admin logs');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not fetch admin logs');
    }
  }

  Future<void> createAdminLog({
    required String userId,
    required String action,
    required Map<String, dynamic> details,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.adminLogs,
        data: {
          'userId': userId,
          'action': action,
          'details': details,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create admin log');
      }
    } on DioException catch (e) {
      throw _handleDioError(e, 'Could not create admin log');
    }
  }

  Exception _handleDioError(DioException error, String defaultMessage) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? defaultMessage;
        return Exception('$message (Status: $statusCode)');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.connectionError:
        return Exception('Connection error. Check your internet connection.');
      case DioExceptionType.badCertificate:
        return Exception('Bad certificate');
      case DioExceptionType.unknown:
        return Exception(error.message ?? defaultMessage);
    }
  }
}
