import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../models/menu_item.dart';
import '../screens/food_detail_screen.dart';
import '../theme/app_theme.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
      ),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Container(
      width: 224,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.divider),
                errorWidget: (_, _, _) => Container(
                  color: AppColors.divider,
                  child: const Icon(Icons.restaurant_menu, color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${item.priceRub} ₽',
            style: GoogleFonts.ptSerif(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.name,
            style: GoogleFonts.ptSerif(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _QuantityControl(item: item),
        ],
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final qty = state.quantityOf(item.id);
        final bloc = context.read<CartBloc>();
        return Container(
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.creamSoft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: qty == 0
              ? _AddButton(onPressed: () => bloc.add(CartItemAdded(item.id)))
              : _StepperRow(
                  qty: qty,
                  onMinus: () => bloc.add(CartItemRemoved(item.id)),
                  onPlus: () => bloc.add(CartItemAdded(item.id)),
                ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: const Center(
        child: Icon(Icons.add, color: AppColors.textPrimary, size: 22),
      ),
    );
  }
}

class _StepperRow extends StatelessWidget {
  const _StepperRow({required this.qty, required this.onMinus, required this.onPlus});
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleBtn(icon: Icons.remove, onTap: onMinus),
        Text(
          '$qty',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        _CircleBtn(icon: Icons.add, onTap: onPlus),
      ],
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, size: 20, color: AppColors.textPrimary),
      ),
    );
  }
}
