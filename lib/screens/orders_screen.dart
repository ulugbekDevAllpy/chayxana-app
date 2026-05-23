import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'order_detail_history_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const _orders = <(String, int, String, String)>[
    ('1203', 1085, '18 нояб 2024г', '18:01'),
    ('1202', 1085, '18 нояб 2024г', '18:01'),
    ('1201', 1085, '18 нояб 2024г', '18:01'),
    ('1200', 1085, '18 нояб 2024г', '18:01'),
    ('1199', 1085, '18 нояб 2024г', '18:01'),
    ('1198', 1085, '18 нояб 2024г', '18:01'),
    ('1197', 1085, '18 нояб 2024г', '18:01'),
    ('1196', 1085, '18 нояб 2024г', '18:01'),
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
                _Header(title: l.orders, onClose: () => Navigator.of(context).maybePop()),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: _orders.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (_, i) {
                      final (id, amount, date, time) = _orders[i];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => OrderDetailHistoryScreen(orderId: id, amount: amount),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$amount ₽',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '$date · $time · ${l.delivered}',
                                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                            ],
                          ),
                        ),
                      );
                    },
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
