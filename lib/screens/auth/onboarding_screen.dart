import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../home_screen.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _skip(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _openSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  void _openLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _skip(context),
                    child: const Text(
                      'Пропустить',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: _Logo(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  const Text(
                    'Войдите в профиль',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Чтобы заработать бонусные монеты и получить\nперсональные предложения',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _openSignUp(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => _openLogin(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.card,
                        foregroundColor: AppColors.textPrimary,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      child: const Text(
                        'Войти',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: const Size(140, 140), painter: _TeapotPainter()),
        const SizedBox(height: 16),
        const Text(
          'ЧАЙХАНА',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'ТАШКЕНТ СИТИ',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

class _TeapotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primary..style = PaintingStyle.fill;
    final w = size.width;
    final h = size.height;
    final body = Path()
      ..moveTo(w * 0.25, h * 0.45)
      ..quadraticBezierTo(w * 0.2, h * 0.85, w * 0.45, h * 0.9)
      ..lineTo(w * 0.7, h * 0.9)
      ..quadraticBezierTo(w * 0.85, h * 0.85, w * 0.82, h * 0.55)
      ..quadraticBezierTo(w * 0.75, h * 0.4, w * 0.5, h * 0.42)
      ..quadraticBezierTo(w * 0.3, h * 0.42, w * 0.25, h * 0.45)
      ..close();
    canvas.drawPath(body, paint);
    final spout = Path()
      ..moveTo(w * 0.82, h * 0.55)
      ..quadraticBezierTo(w * 0.98, h * 0.45, w * 0.95, h * 0.3)
      ..lineTo(w * 0.88, h * 0.32)
      ..quadraticBezierTo(w * 0.88, h * 0.45, w * 0.78, h * 0.6)
      ..close();
    canvas.drawPath(spout, paint);
    final lid = Path()
      ..moveTo(w * 0.4, h * 0.42)
      ..quadraticBezierTo(w * 0.55, h * 0.28, w * 0.7, h * 0.42)
      ..close();
    canvas.drawPath(lid, paint);
    canvas.drawCircle(Offset(w * 0.55, h * 0.25), w * 0.04, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

