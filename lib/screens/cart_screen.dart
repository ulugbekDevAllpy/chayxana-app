import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart' as cart;
import '../data/menu_data.dart';
import '../l10n/app_localizations.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.4),
        transitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => const CartScreen(),
        transitionsBuilder: (_, anim, _, child) => SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promo = TextEditingController();
  bool _promoExpanded = false;
  int _promoDiscount = 0;

  @override
  void dispose() {
    _promo.dispose();
    super.dispose();
  }

  void _applyPromo() {
    setState(() {
      _promoDiscount = _promo.text.trim().isNotEmpty ? 300 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.creamSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _Header(onClose: () => Navigator.of(context).maybePop()),
                Expanded(
                  child: BlocBuilder<CartBloc, cart.CartState>(
                    builder: (context, cartState) {
                      final l = AppL10n.of(context);
                      final cartItems = _cartItems(cartState);
                      if (cartItems.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              l.cartEmpty,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                            ),
                          ),
                        );
                      }
                      final goods = _goodsTotal(cartItems);
                      final total = goods - _promoDiscount;
                      return Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  for (final ci in cartItems) _CartRow(item: ci.item, qty: ci.qty),
                                  const SizedBox(height: 8),
                                  _SuggestionRow(items: _suggestions(cartItems)),
                                  const SizedBox(height: 12),
                                  _PromoSection(
                                    controller: _promo,
                                    expanded: _promoExpanded,
                                    onToggle: () => setState(() => _promoExpanded = !_promoExpanded),
                                    onApply: _applyPromo,
                                  ),
                                  const SizedBox(height: 16),
                                  _Summary(goods: goods, promo: _promoDiscount, total: total),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CheckoutScreen(total: total),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                ),
                                child: Text(
                                  'Оформить заказ за $total ₽',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  List<_CartItem> _cartItems(cart.CartState state) {
    final out = <_CartItem>[];
    state.quantities.forEach((id, qty) {
      final item = menuItems.firstWhere((m) => m.id == id, orElse: () => menuItems.first);
      out.add(_CartItem(item, qty));
    });
    return out;
  }

  int _goodsTotal(List<_CartItem> items) =>
      items.fold(0, (sum, ci) => sum + ci.item.priceRub * ci.qty);

  List<MenuItem> _suggestions(List<_CartItem> inCart) {
    final cartIds = inCart.map((c) => c.item.id).toSet();
    return menuItems.where((m) => !cartIds.contains(m.id)).take(6).toList();
  }
}

class _CartItem {
  const _CartItem(this.item, this.qty);
  final MenuItem item;
  final int qty;
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        children: [
          const SizedBox(width: 36),
          const Expanded(
            child: Center(
              child: Text('Корзина', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

class _CartRow extends StatelessWidget {
  const _CartRow({required this.item, required this.qty});
  final MenuItem item;
  final int qty;

  @override
  Widget build(BuildContext context) {
    final total = item.priceRub * qty;
    final oldTotal = item.oldPriceRub != null ? item.oldPriceRub! * qty : null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 56,
              height: 56,
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.divider),
                errorWidget: (_, _, _) => Container(color: AppColors.divider),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                _MiniStepper(item: item, qty: qty),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('350 г', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              if (oldTotal != null) ...[
                Text(
                  '$oldTotal ₽',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
              Text(
                '$total ₽',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStepper extends StatelessWidget {
  const _MiniStepper({required this.item, required this.qty});
  final MenuItem item;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _SBtn(icon: Icons.remove, onTap: () => context.read<CartBloc>().add(CartItemRemoved(item.id))),
          Text('$qty', style: const TextStyle(fontWeight: FontWeight.w600)),
          _SBtn(icon: Icons.add, onTap: () => context.read<CartBloc>().add(CartItemAdded(item.id))),
        ],
      ),
    );
  }
}

class _SBtn extends StatelessWidget {
  const _SBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(width: 30, height: 30, child: Icon(icon, size: 16)),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.items});
  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            'Добавить к заказу?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, i) => _SuggestionCard(item: items[i]),
          ),
        ),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.divider),
                errorWidget: (_, _, _) => Container(color: AppColors.divider),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text('200 гр', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          InkWell(
            onTap: () => context.read<CartBloc>().add(CartItemAdded(item.id)),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${item.priceRub} ₽',
                    style: const TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.add, size: 14, color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoSection extends StatelessWidget {
  const _PromoSection({
    required this.controller,
    required this.expanded,
    required this.onToggle,
    required this.onApply,
  });
  final TextEditingController controller;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: expanded
            ? Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Промокод',
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    InkWell(
                      onTap: onApply,
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              )
            : InkWell(
                onTap: onToggle,
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.confirmation_number_outlined, size: 18, color: AppColors.textPrimary),
                      const SizedBox(width: 8),
                      const Text('Есть промокод?'),
                      const Spacer(),
                      const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.goods, required this.promo, required this.total});
  final int goods;
  final int promo;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (promo > 0)
            _SummaryRow(label: 'Промокод', value: '-$promo ₽', valueColor: AppColors.accent),
          _SummaryRow(label: 'Товары с учётом скидки', value: '$goods ₽'),
          const _SummaryRow(label: 'Бонусы', value: '50 Coins'),
          const _SummaryRow(label: 'Доставка', value: '0 ₽'),
          const Divider(color: AppColors.divider),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: valueColor ?? AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
