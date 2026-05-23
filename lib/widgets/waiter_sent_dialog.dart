import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WaiterSentDialog {
  static Future<void> show(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => const _WaiterSentDialogBody(),
      transitionBuilder: (_, anim, _, child) {
        final t = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return Transform.scale(
          scale: 0.85 + 0.15 * t.value,
          child: Opacity(opacity: anim.value, child: child),
        );
      },
    );
  }
}

class _WaiterSentDialogBody extends StatefulWidget {
  const _WaiterSentDialogBody();

  @override
  State<_WaiterSentDialogBody> createState() => _WaiterSentDialogBodyState();
}

class _WaiterSentDialogBodyState extends State<_WaiterSentDialogBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 280,
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 3),
                ),
                child: const Icon(Icons.check, color: AppColors.accent, size: 40),
              ),
              const SizedBox(height: 18),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const Text(
                    'Официант уже в пути\nк вам!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Positioned(
                    left: -8,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.divider,
                        border: Border.all(color: AppColors.card, width: 2),
                      ),
                      child: const Icon(Icons.person, size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
