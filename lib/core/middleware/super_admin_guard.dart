// lib/core/middleware/super_admin_guard.dart
import 'package:flutter/material.dart';

import '../../features/auth/providers/auth_provider.dart';

class SuperAdminGuard extends StatelessWidget {
  final Widget child;

  const SuperAdminGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (!auth.currentUser?.role.isSuperAdmin ?? false) {
          return const Scaffold(
            body: Center(
              child: Text('Access Denied: Super Admin privileges required'),
            ),
          );
        }

        return child;
      },
    );
  }
}
