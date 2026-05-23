import 'package:flutter/material.dart';

import '../../widgets/auth_widgets.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _obscure1 = false;
  bool _obscure2 = true;

  bool get _filled => _p1.text.isNotEmpty && _p2.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _p1.addListener(() => setState(() {}));
    _p2.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _p1.dispose();
    _p2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      backLabel: 'back',
      topRightLabel: 'Сброс пароля',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthTitle(
                    'Установите новый\nпароль',
                    subtitle:
                        'Введите новый пароль, чтобы иметь\nвозможность войти в свой аккаунт заново',
                  ),
                  UnderlineField(
                    label: 'Установите пароль',
                    controller: _p1,
                    obscure: _obscure1,
                    onToggleObscure: () => setState(() => _obscure1 = !_obscure1),
                  ),
                  UnderlineField(
                    label: 'Введите пароль',
                    controller: _p2,
                    obscure: _obscure2,
                    onToggleObscure: () => setState(() => _obscure2 = !_obscure2),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: PrimaryButton(
              label: 'Утвердить',
              onPressed: _filled
                  ? () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(successMessage: 'Пароль был изменен'),
                        ),
                        (_) => false,
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
