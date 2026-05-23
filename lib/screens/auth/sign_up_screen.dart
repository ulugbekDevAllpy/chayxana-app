import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/auth_widgets.dart';
import 'login_screen.dart';
import 'verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phone = TextEditingController(text: '+7');
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _promo = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  String? _phoneError;

  bool get _formFilled =>
      _phone.text.length > 4 && _password.text.isNotEmpty && _confirm.text.isNotEmpty;

  void _next() {
    if (!_isValidPhone(_phone.text)) {
      setState(() => _phoneError = 'Неправильный номер телефона');
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VerificationScreen(phone: _phone.text, fromSignUp: true),
      ),
    );
  }

  bool _isValidPhone(String s) {
    final digits = s.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 11;
  }

  @override
  void initState() {
    super.initState();
    for (final c in [_phone, _password, _confirm, _promo]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    _promo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      backLabel: 'Назад',
      topRightLabel: 'Регистрация',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthTitle('Давайте создадим\nаккаунт'),
                  UnderlineField(
                    label: 'Номер Телефона',
                    controller: _phone,
                    error: _phoneError,
                    keyboardType: TextInputType.phone,
                  ),
                  UnderlineField(
                    label: 'Установите пароль',
                    controller: _password,
                    obscure: _obscure1,
                    onToggleObscure: () => setState(() => _obscure1 = !_obscure1),
                  ),
                  UnderlineField(
                    label: 'Подтвердите пароль',
                    controller: _confirm,
                    obscure: _obscure2,
                    onToggleObscure: () => setState(() => _obscure2 = !_obscure2),
                  ),
                  UnderlineField(label: 'Промокод', controller: _promo),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: PrimaryButton(
              label: 'Далее',
              onPressed: _formFilled ? _next : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'У вас уже есть аккаунт? ',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text(
                    'Войти',
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
    );
  }
}
