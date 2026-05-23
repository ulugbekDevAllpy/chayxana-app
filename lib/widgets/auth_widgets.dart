import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.child,
    this.backLabel,
    this.topRightLabel,
    this.onBack,
    this.onTopRight,
  });

  final Widget child;
  final String? backLabel;
  final String? topRightLabel;
  final VoidCallback? onBack;
  final VoidCallback? onTopRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 4),
              child: Row(
                children: [
                  if (backLabel != null)
                    TextButton.icon(
                      onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, size: 18, color: AppColors.textPrimary),
                      label: Text(backLabel!, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15)),
                    ),
                  const Spacer(),
                  if (topRightLabel != null)
                    TextButton(
                      onPressed: onTopRight,
                      child: Text(
                        topRightLabel!,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class AuthTitle extends StatelessWidget {
  const AuthTitle(this.text, {super.key, this.subtitle});
  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.15,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 10),
            Text(
              subtitle!,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}

class UnderlineField extends StatelessWidget {
  const UnderlineField({
    super.key,
    required this.label,
    required this.controller,
    this.error,
    this.obscure = false,
    this.onToggleObscure,
    this.suffix,
    this.keyboardType,
    this.hint,
  });

  final String label;
  final TextEditingController controller;
  final String? error;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: error != null ? Colors.redAccent : AppColors.divider),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: error != null ? Colors.redAccent : AppColors.primary),
              ),
              suffixIcon: onToggleObscure != null
                  ? IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : suffix,
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 14, color: Colors.redAccent),
                  const SizedBox(width: 4),
                  Text(error!, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.expanded = true});
  final String label;
  final VoidCallback? onPressed;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.35),
        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
    if (!expanded) return button;
    return SizedBox(width: double.infinity, height: 52, child: button);
  }
}
