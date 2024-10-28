// lib/main.dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/config/app_config.dart';
import 'core/config/env.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/home/providers/home_provider.dart';
import 'routes/router.dart';
import 'services/service_locator.dart';

enum Environment { development, staging, production }

Future<void> loadEnvironment(Environment env) async {
  switch (env) {
    case Environment.development:
      await dotenv.load(fileName: ".env.development");
      break;
    case Environment.staging:
      await dotenv.load(fileName: ".env.staging");
      break;
    case Environment.production:
      await dotenv.load(fileName: ".env.production");
      break;
  }
}

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              child: const Icon(Icons.developer_mode),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const DevelopmentMenu(),
                );
              },
            )
          : null,
    );
  }
}

class DevelopmentMenu extends StatelessWidget {
  const DevelopmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Development Menu',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Current Environment: ${Env.apiUrl}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text('Development'),
            subtitle: const Text('Local Environment'),
            onTap: () => _changeEnvironment(context, Environment.development),
          ),
          ListTile(
            title: const Text('Staging'),
            subtitle: const Text('Test Environment'),
            onTap: () => _changeEnvironment(context, Environment.staging),
          ),
          ListTile(
            title: const Text('Production'),
            subtitle: const Text('Live Environment'),
            onTap: () => _changeEnvironment(context, Environment.production),
          ),
        ],
      ),
    );
  }

  Future<void> _changeEnvironment(BuildContext context, Environment env) async {
    try {
      await loadEnvironment(env);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Switched to ${env.name} environment'),
            action: SnackBarAction(
              label: 'Restart',
              onPressed: () {
                // Här kan du implementera app restart
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to switch environment: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await loadEnvironment(Environment.development);

    print('Running on: ${Platform.operatingSystem}');
    print('Using API URL: ${Env.apiUrl}');

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    await setupServiceLocator();
    await AppConfig.initialize();

    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'GoatrikHub',
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              if (child == null) return const SizedBox.shrink();

              return AppScaffold(child: child);
            },
          );
        },
      ),
    );
  }
}
