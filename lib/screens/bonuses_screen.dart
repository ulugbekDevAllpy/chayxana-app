import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class BonusesScreen extends StatelessWidget {
  const BonusesScreen({super.key});

  static const _entries = <(int, String)>[
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
    (100, '18 нояб 2024г'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.creamSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _Header(title: l.bonuses, onClose: () => Navigator.of(context).maybePop()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l.coinAccrual,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _entries.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '+${_entries[i].$1}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.accent,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.cookie, color: AppColors.accent, size: 16),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _entries[i].$2,
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onClose});
  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        children: [
          const SizedBox(width: 36),
          Expanded(
            child: Center(
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
