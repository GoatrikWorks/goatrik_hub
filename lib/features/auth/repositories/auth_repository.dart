import '../../../core/config/constants.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/mock_dio_client.dart';
import '../../../core/storage/secure_storage.dart';
import '../../home/enums/user_role.dart';
import '../models/user.dart';

class AuthRepository {
  final ApiClient _dioClient;
  final SecureStorage _secureStorage = SecureStorage();

  AuthRepository({bool useMock = false})
      : _dioClient = useMock ? MockDioClient() : DioClient();

  Future<User> login(String email, String password) async {
    final response = await _dioClient.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = response.data;
      final user = User.fromJson(data['user']);
      final token = data['token'];

      // Spara token
      await _secureStorage.write(key: Constants.tokenKey, value: token);

      return user;
    } else {
      throw Exception('Misslyckades att logga in');
    }
  }

  Future<User> register(String name, String email, String password) async {
    final response = await _dioClient.post(ApiEndpoints.register, data: {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      final data = response.data;
      final user = User.fromJson(data['user']);
      final token = data['token'];

      // Spara token
      await _secureStorage.write(key: Constants.tokenKey, value: token);

      return user;
    } else {
      throw Exception('Misslyckades att registrera');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: Constants.tokenKey);
  }

  Future<User> updateProfile(User updatedUser) async {
    final response = await _dioClient.put(ApiEndpoints.updateProfile, data: {
      'name': updatedUser.name,
      'email': updatedUser.email,
      'role': updatedUser.role?.toString(),
    });

    if (response.statusCode == 200) {
      final data = response.data;
      return User.fromJson(data['user']);
    } else {
      throw Exception('Misslyckades att uppdatera profil');
    }
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    final response =
        await _dioClient.put(ApiEndpoints.updateUserRole(userId), data: {
      'role': newRole.toString(),
    });

    if (response.statusCode != 200) {
      throw Exception('Misslyckades att uppdatera användarroll');
    }
  }
}
