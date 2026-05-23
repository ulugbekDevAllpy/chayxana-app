import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CamelIcon extends StatelessWidget {
  const CamelIcon({super.key, this.size = 32, this.color});
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _CamelPainter(color: color ?? AppColors.textPrimary)),
    );
  }
}

class _CamelPainter extends CustomPainter {
  _CamelPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.10, h * 0.78)
      ..lineTo(w * 0.10, h * 0.55)
      ..quadraticBezierTo(w * 0.20, h * 0.40, w * 0.30, h * 0.55)
      ..quadraticBezierTo(w * 0.40, h * 0.35, w * 0.55, h * 0.55)
      ..quadraticBezierTo(w * 0.65, h * 0.45, w * 0.75, h * 0.55)
      ..lineTo(w * 0.78, h * 0.40)
      ..quadraticBezierTo(w * 0.85, h * 0.30, w * 0.92, h * 0.35)
      ..lineTo(w * 0.90, h * 0.55)
      ..lineTo(w * 0.85, h * 0.78)
      ..lineTo(w * 0.78, h * 0.78)
      ..lineTo(w * 0.78, h * 0.65)
      ..lineTo(w * 0.65, h * 0.65)
      ..lineTo(w * 0.65, h * 0.78)
      ..lineTo(w * 0.58, h * 0.78)
      ..lineTo(w * 0.58, h * 0.65)
      ..lineTo(w * 0.30, h * 0.65)
      ..lineTo(w * 0.30, h * 0.78)
      ..lineTo(w * 0.22, h * 0.78)
      ..lineTo(w * 0.22, h * 0.65)
      ..lineTo(w * 0.15, h * 0.65)
      ..lineTo(w * 0.15, h * 0.78)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(w * 0.88, h * 0.40), w * 0.015, Paint()..color = AppColors.creamSoft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
