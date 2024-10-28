import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum UserRole {
  @JsonValue('user')
  user,

  @JsonValue('admin')
  admin,

  @JsonValue('superadmin')
  superAdmin;

  const UserRole();

  // Helper method to check if the role is SuperAdmin
  bool get isSuperAdmin => this == UserRole.superAdmin;

  // Helper method to check if the role is at least Admin level
  bool get isAdmin => this == UserRole.admin || this == UserRole.superAdmin;

  // Provides a display name for each role
  String get displayName {
    switch (this) {
      case UserRole.user:
        return 'Användare';
      case UserRole.admin:
        return 'Admin';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }

  // Provides a list of permissions associated with each role
  List<String> get permissions {
    switch (this) {
      case UserRole.user:
        return ['read:own_profile', 'update:own_profile'];
      case UserRole.admin:
        return [
          ...UserRole.user.permissions, // Inherit user permissions
          'read:users',
          'update:users'
        ];
      case UserRole.superAdmin:
        return [
          ...UserRole.admin.permissions, // Inherit admin permissions
          'delete:users',
          'manage:roles'
        ];
    }
  }

  // Method to check if a role has a specific permission
  bool hasPermission(String permission) => permissions.contains(permission);

  // Factory method for deserializing from JSON
  static UserRole fromJson(String json) {
    switch (json) {
      case 'user':
        return UserRole.user;
      case 'admin':
        return UserRole.admin;
      case 'superadmin':
        return UserRole.superAdmin;
      default:
        throw ArgumentError('Invalid UserRole: $json');
    }
  }

  // Method to serialize to JSON
  String toJson() {
    switch (this) {
      case UserRole.user:
        return 'user';
      case UserRole.admin:
        return 'admin';
      case UserRole.superAdmin:
        return 'superadmin';
    }
  }
}
