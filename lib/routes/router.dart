import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/middleware/super_admin_guard.dart';
import '../features/admin/screens/super_admin_screen.dart';
import '../features/auth/providers/auth_provider.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/home/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final authProvider = context.read<AuthProvider>();
        if (authProvider.user != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/super-admin',
      builder: (context, state) => SuperAdminGuard(
        child: const SuperAdminScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    // Lägg till fler rutter här
  ],
);
