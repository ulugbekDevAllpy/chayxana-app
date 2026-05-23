import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'auth/onboarding_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _fade = CurvedAnimation(parent: _logoController, curve: Curves.easeOut);
    _scale = Tween(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (!mounted) return;
      final loggedIn = context.read<AuthBloc>().state.isLoggedIn;
      final next = loggedIn ? const HomeScreen() : const OnboardingScreen();
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, _, _) => next,
          transitionsBuilder: (_, anim, _, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _PatternPainter())),
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: const _LogoMark(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: const Size(120, 120), painter: _TeapotPainter()),
        const SizedBox(height: 20),
        Text(
          l.splashTitle,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l.splashSubtitle,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 13,
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
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

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

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    const spacing = 60.0;
    for (var x = -spacing; x < size.width + spacing; x += spacing) {
      for (var y = -spacing; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), 3, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
