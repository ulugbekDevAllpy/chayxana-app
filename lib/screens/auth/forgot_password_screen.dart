import 'package:flutter/material.dart';

import '../../widgets/auth_widgets.dart';
import 'verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phone = TextEditingController(text: '+7 995 120 1228');

  @override
  void initState() {
    super.initState();
    _phone.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phone.dispose();
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
                    'С возвращением',
                    subtitle:
                        'Введите свой номер телефона, чтобы получить\nкод подтверждения для сброса пароля',
                  ),
                  UnderlineField(
                    label: 'Номер Телефона',
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: PrimaryButton(
              label: 'Далее',
              onPressed: _phone.text.length >= 6
                  ? () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VerificationScreen(
                            phone: _phone.text,
                            fromSignUp: false,
                            forPasswordReset: true,
                          ),
                        ),
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
