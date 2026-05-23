import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_fab.dart';
import '../widgets/category_chip.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';
import 'search_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  String _activeCategoryId = menuCategories.first.id;
  final Map<String, GlobalKey> _categoryKeys = {
    for (final c in menuCategories) c.id: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCategory(String categoryId) {
    final key = _categoryKeys[categoryId];
    if (key?.currentContext == null) return;
    setState(() => _activeCategoryId = categoryId);
    Scrollable.ensureVisible(
      key!.currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Меню'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _CategoryBarDelegate(
                  activeId: _activeCategoryId,
                  onSelect: _scrollToCategory,
                ),
              ),
              for (final cat in menuCategories) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    key: _categoryKeys[cat.id],
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                    child: Text(
                      cat.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                _CategoryGrid(
                  items: menuItems.where((m) => m.categoryId == cat.id).toList(),
                ),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 24,
            child: CartFab(onTap: () => CartScreen.show(context)),
          ),
        ],
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.items});
  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, i) => MenuItemCard(item: items[i]),
          childCount: items.length,
        ),
      ),
    );
  }
}

class _CategoryBarDelegate extends SliverPersistentHeaderDelegate {
  _CategoryBarDelegate({required this.activeId, required this.onSelect});
  final String activeId;
  final ValueChanged<String> onSelect;

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.creamSoft,
      alignment: Alignment.center,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: menuCategories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = menuCategories[i];
          return Center(
            child: CategoryChip(
              label: c.name,
              selected: c.id == activeId,
              onTap: () => onSelect(c.id),
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CategoryBarDelegate old) => old.activeId != activeId;
}
