import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../theme/app_theme.dart';
import '../../widgets/auth_widgets.dart';
import '../home_screen.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.successMessage});
  final String? successMessage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController(text: '+7');
  final _password = TextEditingController();
  bool _obscure = true;
  String? _passwordError;
  bool _showSuccess = false;

  bool get _formFilled => _phone.text.length > 4 && _password.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _phone.addListener(() => setState(() {}));
    _password.addListener(() => setState(() {
          _passwordError = null;
        }));

    if (widget.successMessage != null) {
      _showSuccess = true;
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showSuccess = false);
      });
    }
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_password.text.length < 4) {
      setState(() => _passwordError = 'Неверный пароль, попробуйте еще раз');
      return;
    }
    context.read<AuthBloc>().add(AuthSignInRequested(_phone.text));
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AuthScaffold(
          backLabel: 'back',
          topRightLabel: 'Войти',
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AuthTitle('С возвращением'),
                      UnderlineField(
                        label: 'Номер Телефона',
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                      ),
                      UnderlineField(
                        label: 'Введите пароль',
                        controller: _password,
                        obscure: _obscure,
                        onToggleObscure: () => setState(() => _obscure = !_obscure),
                        error: _passwordError,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                          ),
                          child: const Text(
                            'Забыли пароль?',
                            style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: PrimaryButton(
                  label: 'Войти',
                  onPressed: _formFilled ? _signIn : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'У вас нет аккаунта? ',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_showSuccess)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: Material(
                color: Colors.white,
                elevation: 6,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Успешно!', style: TextStyle(fontWeight: FontWeight.w700)),
                            Text('Пароль был изменен',
                                style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _showSuccess = false),
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
