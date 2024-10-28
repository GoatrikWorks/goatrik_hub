import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Liknande struktur som LoginScreen men med anpassningar för registrering
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Lottie.asset(
                'assets/animations/signup_animation.json',
                height: 200,
              ),
              const SizedBox(height: 32),
              Text(
                'Skapa Konto',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Registrera dig för att komma igång',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      label: 'Namn',
                      prefix: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ange ditt namn';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: 'E-post',
                      keyboardType: TextInputType.emailAddress,
                      prefix: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      validator: Validators.validateEmail,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Lösenord',
                      obscureText: !_isPasswordVisible,
                      prefix: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: Validators.validatePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  return ElevatedButton(
                    onPressed: auth.loading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await auth.register(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                if (mounted) {
                                  context.go('/home');
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                }
                              }
                            }
                          },
                    child: auth.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Registrera'),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: Text(
                  'Redan medlem? Logga in',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
