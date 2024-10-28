import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/enums/user_role.dart';
import '../providers/auth_provider.dart';

class RoleGuard extends StatelessWidget {
  final Widget child;
  final UserRole minimumRole;
  final Widget? fallback;
  final List<String>? requiredPermissions;

  const RoleGuard({
    Key? key,
    required this.child,
    this.minimumRole = UserRole.user,
    this.fallback,
    this.requiredPermissions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final user = auth.user;

        if (user == null) {
          return fallback ??
              const Center(child: Text('Please log in to access this page'));
        }

        final hasRequiredRole = user.role.index >= minimumRole.index;
        if (!hasRequiredRole) {
          return fallback ??
              Center(
                child: Text(
                  'Access denied. Minimum role required: ${minimumRole.displayName}',
                ),
              );
        }

        if (requiredPermissions != null && requiredPermissions!.isNotEmpty) {
          final hasAllPermissions = requiredPermissions!
              .every((permission) => user.hasPermission(permission));
          if (!hasAllPermissions) {
            return fallback ??
                const Center(
                  child: Text('Access denied. Insufficient permissions.'),
                );
          }
        }

        return child;
      },
    );
  }
}
