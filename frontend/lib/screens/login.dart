import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/navigation/route_names.dart';
import 'package:frontend/services/user_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../exceptions/sign_in_exception.dart';
import '../providers/user_providers.dart';
import '../services/auth_service.dart';
import '../utils/error_mapper.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    debugPrint('LoginPage disposed');
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  submit() async {
    final provider = ref.watch(userProvider.notifier);
    try {
      if (_formKey.currentState!.validate()) {
        await authService.loginWithEmailAndPassword(
            _emailController.text, _passwordController.text);

        AppUser? user = await UserService.getCurrentUser();
        if (user != null) {
          provider.setUser(user);
        }
      }
    } on SignInException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ErrorMapper.mapRegistrationAndLoginErrors(
                context,
                error.message,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: Text(
                    translations.loginPageTitle,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            label: Text(translations.emailLabel),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translations.emailIsEmptyError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            label: Text(translations.passwordLabel),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translations.passwordIsEmptyError;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: submit,
                      child: Text(translations.commonSubmit),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(routeRegistration),
                      child: Text(translations.commonRegister),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
