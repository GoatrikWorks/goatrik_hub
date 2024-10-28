import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/user_role.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    @Default(UserRole.user) UserRole role,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    @Default(false) bool isEmailVerified,
    String? avatarUrl,
    Map<String, dynamic>? metadata,
  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  bool hasPermission(String permission) => role.hasPermission(permission);
  bool get isAdmin => role.isAdmin;
  bool get isSuperAdmin => role.isSuperAdmin;
}
