import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum UserRole {
  @JsonValue('user')
  user,

  @JsonValue('admin')
  admin,

  @JsonValue('super_admin')
  superAdmin;

  const UserRole();

  bool get isSuperAdmin => this == UserRole.superAdmin;
  bool get isAdmin => this == UserRole.admin || this == UserRole.superAdmin;

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

  String get description {
    switch (this) {
      case UserRole.user:
        return 'Standard användarbehörighet';
      case UserRole.admin:
        return 'Administratörsbehörighet';
      case UserRole.superAdmin:
        return 'Super administratörsbehörighet';
    }
  }

  List<String> get permissions {
    switch (this) {
      case UserRole.user:
        return [
          'read:own_profile',
          'update:own_profile',
        ];
      case UserRole.admin:
        return [
          'read:own_profile',
          'update:own_profile',
          'read:users',
          'update:users',
          'create:content',
          'update:content',
          'delete:content',
        ];
      case UserRole.superAdmin:
        return [
          'read:own_profile',
          'update:own_profile',
          'read:users',
          'create:users',
          'update:users',
          'delete:users',
          'create:content',
          'update:content',
          'delete:content',
          'manage:settings',
          'view:analytics',
          'manage:roles',
        ];
    }
  }

  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
}
