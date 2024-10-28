import 'package:flutter/foundation.dart';

import '../../auth/models/user.dart';
import '../../home/enums/user_role.dart';

class SuperAdminProvider extends ChangeNotifier {
  final SuperAdminRepository _repository;

  SuperAdminProvider({SuperAdminRepository? repository})
      : _repository = repository ?? SuperAdminRepository();

  bool _isLoading = false;
  String? _error;
  List<User> _users = [];
  AdminSettings? _settings;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<User> get users => _users;
  AdminSettings? get settings => _settings;

  Future<void> fetchUsers() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _users = await _repository.getAllUsers();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.updateUserRole(userId, newRole);
      await fetchUsers(); // Refresh user list
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.deleteUser(userId);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSettings(AdminSettings settings) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.updateSettings(settings);
      _settings = settings;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class SuperAdminRepository {}

class AdminSettings {}
