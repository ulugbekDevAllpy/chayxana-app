import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../theme/app_theme.dart';

class CartFab extends StatelessWidget {
  const CartFab({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final count = state.itemCount;
        if (count == 0) return const SizedBox.shrink();
        return Material(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28),
          elevation: 6,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '·  $count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
