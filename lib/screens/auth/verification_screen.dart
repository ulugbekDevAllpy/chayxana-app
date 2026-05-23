import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../theme/app_theme.dart';
import '../../widgets/auth_widgets.dart';
import '../home_screen.dart';
import 'new_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
    required this.phone,
    this.fromSignUp = true,
    this.forPasswordReset = false,
  });

  final String phone;
  final bool fromSignUp;
  final bool forPasswordReset;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _code = TextEditingController();
  String? _error;
  int _secondsLeft = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _code.addListener(() => setState(() => _error = null));
    _startTimer();
  }

  void _startTimer() {
    setState(() => _secondsLeft = 59);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  @override
  void dispose() {
    _code.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_code.text == '12345') {
      if (widget.forPasswordReset) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
        );
        return;
      }
      context.read<AuthBloc>().add(AuthSignInRequested(widget.phone));
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } else {
      setState(() => _error = 'Неправильный код, попробуйте еще раз');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      backLabel: 'Назад',
      topRightLabel: widget.fromSignUp ? 'Регистрация' : 'Войти',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthTitle(
                    'Подтвердите свой\nномер телефона',
                    subtitle:
                        'Мы только что отправили вам проверочный код\nна номер телефона ${widget.phone}',
                  ),
                  UnderlineField(
                    label: 'Код проверки',
                    controller: _code,
                    error: _error,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 72,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Center(
                    child: _secondsLeft > 0
                        ? Text(
                            '0:${_secondsLeft.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            onPressed: _startTimer,
                            icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Далее',
                    onPressed: _code.text.length >= 4 ? _submit : null,
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
