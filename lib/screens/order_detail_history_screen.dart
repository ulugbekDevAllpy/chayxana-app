import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class OrderDetailHistoryScreen extends StatelessWidget {
  const OrderDetailHistoryScreen({super.key, required this.orderId, required this.amount});
  final String orderId;
  final int amount;

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
                _Header(title: l.order, onClose: () => Navigator.of(context).maybePop()),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderId,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$amount ₽',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '18 нояб 2024г · 18:01 · ${l.delivered}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 20),
                        const _ItemRow(name: 'Шашлычное ассорти на 4 персоны', price: 485, qty: 1),
                        const Divider(color: AppColors.divider),
                        const _ItemRow(name: 'Шашлычное ассорти на 4 персоны', price: 485, qty: 1),
                        const SizedBox(height: 20),
                        Text(l.deliveryDetails,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10),
                        _DetailRow(
                          icon: Icons.local_cafe,
                          title: 'Улица Беруний, 12В, Ташкент',
                          subtitle: l.pickupOrder,
                        ),
                        const SizedBox(height: 10),
                        _DetailRow(
                          icon: Icons.home_outlined,
                          title: '062bKuhn Plains Suite 793',
                          subtitle: l.orderDelivery,
                        ),
                        const SizedBox(height: 20),
                        Text(l.paymentMethod,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10),
                        _DetailRow(
                          icon: Icons.credit_card,
                          title: l.tinkoffPaymentLabel,
                          subtitle: '',
                        ),
                        const SizedBox(height: 20),
                        _SummaryRow(label: l.goodsSubtotal, value: '1 385 ₽'),
                        _SummaryRow(label: l.bonuses, value: '50 Coins'),
                        _SummaryRow(label: l.delivery, value: '0 ₽'),
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

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.name, required this.price, required this.qty});
  final String name;
  final int price;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.restaurant, size: 20, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  '$qty шт · $price ₽',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
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
