import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_state.dart' as auth;
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart' as cart;
import '../data/menu_data.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_card.dart';
import '../widgets/camel_icon.dart';
import '../widgets/cart_fab.dart';
import '../widgets/category_chip.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/waiter_call_sheet.dart';
import '../widgets/waiter_sent_dialog.dart';
import 'address_screen.dart';
import 'auth/onboarding_screen.dart';
import 'cart_screen.dart';
import 'menu_screen.dart';
import 'profile_screen.dart';
import 'story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategoryId = menuCategories.first.id;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    final filtered = menuItems.where((m) => m.categoryId == _selectedCategoryId).toList();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _Header(onTapAddress: _openAddress)),
                SliverToBoxAdapter(child: _StoriesRow(onTapStory: _openStory)),
                SliverToBoxAdapter(
                  child: _SectionHeader(title: l.menu, onTapAll: _openMenu),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: menuCategories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final c = menuCategories[i];
                        return CategoryChip(
                          label: _localCategory(l, c.id),
                          selected: c.id == _selectedCategoryId,
                          onTap: () => setState(() => _selectedCategoryId = c.id),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: _HorizontalItems(items: filtered)),
                SliverToBoxAdapter(
                  child: _SectionHeader(title: l.popular, onTapAll: _openMenu),
                ),
                SliverToBoxAdapter(child: _HorizontalItems(items: popularItems)),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: _BottomActions(onTapCart: _openCart, onCallWaiter: _callWaiter),
            ),
          ],
        ),
      ),
    );
  }

  String _localCategory(AppL10n l, String id) => switch (id) {
        'new' => l.categoryNew,
        'shashlyk' => l.categoryShashlyk,
        'hot' => l.categoryHot,
        'salads' => l.categorySalads,
        'snacks' => l.categorySnacks,
        _ => id,
      };

  void _openMenu() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MenuScreen()));
  }

  void _openCart() => CartScreen.show(context);

  Future<void> _callWaiter() async {
    final ok = await WaiterCallSheet.show(context);
    if (ok == true && mounted) {
      await WaiterSentDialog.show(context);
    }
  }

  void _openAddress() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddressScreen()));
  }

  void _openStory(int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, _, _) => StoryScreen(initialIndex: index),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onTapAddress});
  final VoidCallback onTapAddress;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTapAddress,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const CamelIcon(size: 32),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Народного Ополчения 47к1с1',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.keyboard_arrow_right, size: 18, color: AppColors.textPrimary),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l.freeDelivery,
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              _CoinBadge(),
              SizedBox(height: 6),
              _AvatarButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.onTapCart, required this.onCallWaiter});
  final VoidCallback onTapCart;
  final VoidCallback onCallWaiter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, cart.CartState>(
      builder: (context, state) {
        final hasCart = state.itemCount > 0;
        return Row(
          children: [
            Expanded(child: _WaiterButton(onTap: onCallWaiter)),
            if (hasCart) ...[
              const SizedBox(width: 10),
              CartFab(onTap: onTapCart),
            ],
          ],
        );
      },
    );
  }
}

class _WaiterButton extends StatelessWidget {
  const _WaiterButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(28),
      elevation: 6,
      shadowColor: AppColors.primary.withValues(alpha: 0.4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.notifications_active_outlined, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                l.callWaiter,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoinBadge extends StatelessWidget {
  const _CoinBadge();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, auth.AuthState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cookie_outlined, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                '${state.coins}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, auth.AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.isLoggedIn) {
              ProfileScreen.show(context);
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              );
            }
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider),
            ),
            child: const Icon(
              Icons.sentiment_satisfied,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        );
      },
    );
  }
}

class _StoriesRow extends StatelessWidget {
  const _StoriesRow({required this.onTapStory});
  final ValueChanged<int> onTapStory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: stories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) => StoryThumb(story: stories[i], onTap: () => onTapStory(i)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onTapAll});
  final String title;
  final VoidCallback onTapAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.displayLarge()),
          InkWell(
            onTap: onTapAll,
            borderRadius: BorderRadius.circular(200),
            child: Container(
              width: 64,
              height: 32,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: AppColors.borderSoft, width: 1),
              ),
              child: const Icon(Icons.arrow_forward, size: 16, color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalItems extends StatelessWidget {
  const _HorizontalItems({required this.items});
  final List items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => MenuItemCard(item: items[i]),
      ),
    );
  }
}
