import 'package:flutter/material.dart';

import '../../home/enums/user_role.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  bool _loading = false;
  String? _error;

  AuthProvider({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  User? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _user?.isAdmin ?? false;
  bool get isSuperAdmin => _user?.isSuperAdmin ?? false;

  Future<void> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _authRepository.login(email, password);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _authRepository.register(name, email, password);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
  }) async {
    if (_user == null) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedUser = await _authRepository.updateProfile(
        User(
          id: _user!.id,
          name: name ?? _user!.name,
          email: email ?? _user!.email,
          role: _user!.role,
          avatarUrl: avatarUrl ?? _user!.avatarUrl,
        ),
      );
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> promoteToRole(String userId, UserRole newRole) async {
    if (!isSuperAdmin) {
      throw Exception('Unauthorized: Endast super admin kan ändra roller');
    }

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _authRepository.updateUserRole(userId, newRole);
      if (_user != null && _user!.id == userId) {
        _user = _user!.copyWith(role: newRole);
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> promoteToSuperAdmin(String userId) async {
    await promoteToRole(userId, UserRole.superAdmin);
  }

  Future<void> promoteToAdmin(String userId) async {
    await promoteToRole(userId, UserRole.admin);
  }

  Future<void> revokeAdminRights(String userId) async {
    await promoteToRole(userId, UserRole.user);
  }

  bool hasPermission(String permission) {
    return _user?.hasPermission(permission) ?? false;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
