import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';
import '../widgets/share_sheet.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key, required this.item});
  final MenuItem item;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _selectedPortionIndex = 0;
  int _quantity = 1;
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final portions = item.portions;
    final extra = portions.isNotEmpty ? portions[_selectedPortionIndex].addPriceRub : 0;
    final unitPrice = item.priceRub + extra;
    final total = unitPrice * _quantity;
    final oldUnitPrice = item.oldPriceRub != null ? item.oldPriceRub! + extra : null;

    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageHeader(
                      imageUrl: item.imageUrl,
                      favorite: _favorite,
                      onShare: () => ShareSheet.show(context, item: item),
                      onFavorite: () => setState(() => _favorite = !_favorite),
                      onBack: () => Navigator.of(context).maybePop(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (item.description != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _DescriptionText(text: item.description!),
                      ),
                    if (portions.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      _PortionsList(
                        portions: portions,
                        selectedIndex: _selectedPortionIndex,
                        onSelect: (i) => setState(() => _selectedPortionIndex = i),
                      ),
                    ],
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            _BottomBar(
              quantity: _quantity,
              onQuantityChanged: (q) => setState(() => _quantity = q.clamp(1, 99)),
              totalRub: total,
              oldTotalRub: oldUnitPrice != null ? oldUnitPrice * _quantity : null,
              onAdd: () {
                context.read<CartBloc>().add(CartItemAdded(item.id, times: _quantity));
                Navigator.of(context).maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  const _ImageHeader({
    required this.imageUrl,
    required this.favorite,
    required this.onShare,
    required this.onFavorite,
    required this.onBack,
  });

  final String imageUrl;
  final bool favorite;
  final VoidCallback onShare;
  final VoidCallback onFavorite;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: AppColors.divider),
              errorWidget: (_, _, _) => Container(color: AppColors.divider),
            ),
          ),
        ),
        Positioned(
          left: 12,
          top: 12,
          child: _CircleIconButton(icon: Icons.arrow_back, onTap: onBack),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Row(
            children: [
              _CircleIconButton(icon: Icons.ios_share, onTap: onShare),
              const SizedBox(width: 8),
              _CircleIconButton(
                icon: favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? Colors.redAccent : AppColors.textPrimary,
                onTap: onFavorite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap, this.color});
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: color ?? AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _DescriptionText extends StatefulWidget {
  const _DescriptionText({required this.text});
  final String text;

  @override
  State<_DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<_DescriptionText> {
  bool _expanded = false;
  late final TapGestureRecognizer _toggleRecognizer;

  @override
  void initState() {
    super.initState();
    _toggleRecognizer = TapGestureRecognizer()
      ..onTap = () => setState(() => _expanded = !_expanded);
  }

  @override
  void dispose() {
    _toggleRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > 140;
    final shownText = (!_expanded && isLong) ? '${widget.text.substring(0, 140)}... ' : widget.text;
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.45,
        ),
        children: [
          TextSpan(text: shownText),
          if (isLong)
            TextSpan(
              text: _expanded ? '   Свернуть' : ' Подробнее',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              recognizer: _toggleRecognizer,
            ),
        ],
      ),
    );
  }
}

class _PortionsList extends StatelessWidget {
  const _PortionsList({
    required this.portions,
    required this.selectedIndex,
    required this.onSelect,
  });
  final List<Portion> portions;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < portions.length; i++) ...[
            _PortionTile(
              portion: portions[i],
              selected: i == selectedIndex,
              onTap: () => onSelect(i),
            ),
            if (i < portions.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _PortionTile extends StatelessWidget {
  const _PortionTile({required this.portion, required this.selected, required this.onTap});
  final Portion portion;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _RadioDot(selected: selected),
            const SizedBox(width: 12),
            Text(
              '${portion.pieces} Кусков',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${portion.weightGram}г',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            if (portion.addPriceRub > 0)
              Text(
                '+ ${portion.addPriceRub} ₽',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              )
            else
              const Text(
                '+ 0 ₽',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.accent : AppColors.divider,
          width: 2,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
              ),
            )
          : null,
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.quantity,
    required this.onQuantityChanged,
    required this.totalRub,
    required this.oldTotalRub,
    required this.onAdd,
  });

  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final int totalRub;
  final int? oldTotalRub;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamSoft,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, -2),
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _QtyStepper(
                    value: quantity,
                    onChanged: onQuantityChanged,
                  ),
                  const Spacer(),
                  if (oldTotalRub != null) ...[
                    Text(
                      '$oldTotalRub ₽',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '$totalRub ₽',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onAdd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                  child: const Text(
                    'Добавить',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({required this.value, required this.onChanged});
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 18,
            visualDensity: VisualDensity.compact,
            onPressed: () => onChanged(value - 1),
            icon: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 22,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            iconSize: 18,
            visualDensity: VisualDensity.compact,
            onPressed: () => onChanged(value + 1),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
