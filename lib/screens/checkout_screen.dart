import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'order_tracking_screen.dart';

enum _PaymentMethod { coins, cash, tinkoff }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.total});
  final int total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _PaymentMethod _payment = _PaymentMethod.coins;
  String _address = 'Народного Ополчения 47к1с1';
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _changeAddress() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddressPickerSheet(current: _address),
    );
    if (picked != null) setState(() => _address = picked);
  }

  Future<void> _confirm() async {
    context.read<CartBloc>().add(const CartCleared());
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
      (r) => r.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.deliveryTitle,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel(l.addressLabel),
                    InkWell(
                      onTap: _changeAddress,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(child: Text(_address, style: const TextStyle(fontSize: 15))),
                            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                    const SizedBox(height: 20),
                    _SectionLabel(l.paymentMethod),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _PayChip(
                            label: l.coinsPayment,
                            icon: Icons.cookie_outlined,
                            selected: _payment == _PaymentMethod.coins,
                            onTap: () => setState(() => _payment = _PaymentMethod.coins),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _PayChip(
                            label: l.cashPayment,
                            icon: Icons.payments_outlined,
                            selected: _payment == _PaymentMethod.cash,
                            onTap: () => setState(() => _payment = _PaymentMethod.cash),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _PayChip(
                            label: l.tinkoffPayment,
                            icon: Icons.credit_card,
                            selected: _payment == _PaymentMethod.tinkoff,
                            onTap: () => setState(() => _payment = _PaymentMethod.tinkoff),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _SectionLabel(l.addComment),
                    TextField(
                      controller: _comment,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                children: [
                  _CheckoutRow(label: l.delivery, value: '0 ₽'),
                  _CheckoutRow(label: l.total, value: '${widget.total} ₽', bold: true),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _confirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      ),
                      child: Text(
                        l.placeOrder,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    );
  }
}

class _PayChip extends StatelessWidget {
  const _PayChip({required this.label, required this.icon, required this.selected, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentSoft : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.divider,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? AppColors.accent : AppColors.textPrimary, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppColors.accent : AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutRow extends StatelessWidget {
  const _CheckoutRow({required this.label, required this.value, this.bold = false});
  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: bold ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 16 : 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressPickerSheet extends StatelessWidget {
  const _AddressPickerSheet({required this.current});
  final String current;

  static const _addresses = [
    'Народного Ополчения 47к1с1',
    'Народного Ополчения 47к1с1',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 12),
            for (final a in _addresses)
              InkWell(
                onTap: () => Navigator.of(context).pop(a),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: a == current ? AppColors.accent : Colors.transparent,
                          border: Border.all(color: a == current ? AppColors.accent : AppColors.divider, width: 2),
                        ),
                        child: a == current ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(a)),
                      const Icon(Icons.edit, size: 18, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.divider),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 16),
                    SizedBox(width: 6),
                    Text('Новый адрес'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
