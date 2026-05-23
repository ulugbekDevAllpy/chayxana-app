import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/mock_map.dart';

enum AddressMode { delivery, restaurant }

class SavedAddress {
  const SavedAddress(this.id, this.text);
  final String id;
  final String text;
}

class Restaurant {
  const Restaurant({
    required this.id,
    required this.address,
    required this.city,
    required this.phone,
    required this.hours,
    required this.openUntil,
    required this.kmAway,
    required this.minutesAway,
    required this.photos,
    required this.x,
    required this.y,
    required this.open,
  });
  final String id;
  final String address;
  final String city;
  final String phone;
  final String hours;
  final String openUntil;
  final double kmAway;
  final int minutesAway;
  final List<String> photos;
  final double x;
  final double y;
  final bool open;
}

const _savedAddresses = <SavedAddress>[
  SavedAddress('a1', 'Народного Ополчения 47к1с1'),
  SavedAddress('a2', 'Народного Ополчения 47к1с1'),
  SavedAddress('a3', 'Народного Ополчения 47к1с1'),
  SavedAddress('a4', 'Народного Ополчения 47к1с1'),
];

final _restaurants = <Restaurant>[
  Restaurant(
    id: 'r1',
    address: 'Народного Ополчения 47к1с1',
    city: 'Москва',
    phone: '+7 966 99 97 77',
    hours: '10:00 — 00:00',
    openUntil: 'до 00:00',
    kmAway: 1.2,
    minutesAway: 3,
    photos: [
      'https://picsum.photos/seed/rest1a/400/300',
      'https://picsum.photos/seed/rest1b/400/300',
      'https://picsum.photos/seed/rest1c/400/300',
    ],
    x: 0.55,
    y: 0.35,
    open: true,
  ),
  Restaurant(
    id: 'r2',
    address: 'Профсоюзная 12',
    city: 'Москва',
    phone: '+7 966 99 97 88',
    hours: '10:00 — 00:00',
    openUntil: 'до 00:00',
    kmAway: 2.4,
    minutesAway: 7,
    photos: [
      'https://picsum.photos/seed/rest2a/400/300',
      'https://picsum.photos/seed/rest2b/400/300',
    ],
    x: 0.20,
    y: 0.55,
    open: true,
  ),
  Restaurant(
    id: 'r3',
    address: 'Тверская 8',
    city: 'Москва',
    phone: '+7 966 99 97 99',
    hours: '10:00 — 00:00',
    openUntil: 'до 00:00',
    kmAway: 4.1,
    minutesAway: 12,
    photos: [
      'https://picsum.photos/seed/rest3a/400/300',
    ],
    x: 0.30,
    y: 0.80,
    open: false,
  ),
];

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.initialMode = AddressMode.delivery});
  final AddressMode initialMode;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressMode _mode;
  bool _addingAddress = false;
  String _selectedAddressId = _savedAddresses.first.id;
  Restaurant? _selectedRestaurant;
  bool _restaurantExpanded = false;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  void _setMode(AddressMode mode) {
    setState(() {
      _mode = mode;
      _addingAddress = false;
      _selectedRestaurant = null;
      _restaurantExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _MapArea(
              mode: _mode,
              selectedRestaurant: _selectedRestaurant,
              onSelectRestaurant: (r) => setState(() {
                _selectedRestaurant = r;
                _restaurantExpanded = false;
              }),
            )),
            Positioned(
              left: 12,
              right: 12,
              top: 12,
              child: _TopToggle(
                mode: _mode,
                onChangeMode: _setMode,
                onClose: () => Navigator.of(context).maybePop(),
              ),
            ),
            Positioned(
              right: 16,
              bottom: _bottomSheetHeight() + 12,
              child: _LocateBtn(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              bottom: 0,
              child: _bottomSheet(),
            ),
          ],
        ),
      ),
    );
  }

  double _bottomSheetHeight() {
    if (_mode == AddressMode.delivery) {
      return _addingAddress ? 460 : 360;
    }
    if (_selectedRestaurant != null) {
      return _restaurantExpanded ? 460 : 280;
    }
    return 0;
  }

  Widget _bottomSheet() {
    if (_mode == AddressMode.delivery) {
      return _addingAddress
          ? _AddAddressForm(
              onCancel: () => setState(() => _addingAddress = false),
              onSubmit: () => Navigator.of(context).maybePop(),
            )
          : _SavedAddressesSheet(
              selectedId: _selectedAddressId,
              onSelect: (id) => setState(() => _selectedAddressId = id),
              onAddNew: () => setState(() => _addingAddress = true),
              onConfirm: () => Navigator.of(context).maybePop(),
            );
    }
    if (_selectedRestaurant != null) {
      return _RestaurantSheet(
        restaurant: _selectedRestaurant!,
        expanded: _restaurantExpanded,
        onExpand: () => setState(() => _restaurantExpanded = true),
        onConfirm: () => Navigator.of(context).maybePop(),
      );
    }
    return const SizedBox.shrink();
  }
}

class _MapArea extends StatelessWidget {
  const _MapArea({required this.mode, required this.selectedRestaurant, required this.onSelectRestaurant});
  final AddressMode mode;
  final Restaurant? selectedRestaurant;
  final ValueChanged<Restaurant> onSelectRestaurant;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return Stack(
          children: [
            const Positioned.fill(child: MockMap()),
            if (mode == AddressMode.delivery)
              Positioned(
                left: c.maxWidth / 2 - 22,
                top: c.maxHeight / 2 - 50,
                child: const MapPin(icon: Icons.location_on),
              )
            else
              for (final r in _restaurants)
                Positioned(
                  left: r.x * c.maxWidth - 22,
                  top: r.y * c.maxHeight - 50,
                  child: GestureDetector(
                    onTap: () => onSelectRestaurant(r),
                    child: MapPin(
                      color: selectedRestaurant?.id == r.id ? AppColors.primary : AppColors.accent,
                      icon: Icons.local_cafe,
                      active: r.open,
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }
}

class _TopToggle extends StatelessWidget {
  const _TopToggle({required this.mode, required this.onChangeMode, required this.onClose});
  final AddressMode mode;
  final ValueChanged<AddressMode> onChangeMode;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: _ToggleChip(
                      label: 'Доставка',
                      icon: Icons.delivery_dining,
                      selected: mode == AddressMode.delivery,
                      onTap: () => onChangeMode(AddressMode.delivery),
                    ),
                  ),
                  Expanded(
                    child: _ToggleChip(
                      label: 'В чайхане',
                      icon: Icons.local_cafe,
                      selected: mode == AddressMode.restaurant,
                      onTap: () => onChangeMode(AddressMode.restaurant),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: AppColors.card,
          shape: const CircleBorder(),
          elevation: 2,
          child: InkWell(
            onTap: onClose,
            customBorder: const CircleBorder(),
            child: const SizedBox(width: 44, height: 44, child: Icon(Icons.close, size: 20)),
          ),
        ),
      ],
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({required this.label, required this.icon, required this.selected, required this.onTap});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? Colors.white : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocateBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: const SizedBox(width: 44, height: 44, child: Icon(Icons.navigation, size: 20, color: AppColors.primary)),
      ),
    );
  }
}

class _SheetContainer extends StatelessWidget {
  const _SheetContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.only(bottom: 12),
      ),
    );
  }
}

class _SavedAddressesSheet extends StatelessWidget {
  const _SavedAddressesSheet({
    required this.selectedId,
    required this.onSelect,
    required this.onAddNew,
    required this.onConfirm,
  });
  final String selectedId;
  final ValueChanged<String> onSelect;
  final VoidCallback onAddNew;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Grabber(),
          Row(
            children: [
              const Text('Мои адреса', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton.icon(
                onPressed: onAddNew,
                icon: const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
                label: const Text('Новый адрес', style: TextStyle(color: AppColors.textPrimary)),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.creamSoft,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final a in _savedAddresses)
            _AddressTile(
              address: a,
              selected: a.id == selectedId,
              onTap: () => onSelect(a.id),
            ),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Доставить сюда', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressTile extends StatelessWidget {
  const _AddressTile({required this.address, required this.selected, required this.onTap});
  final SavedAddress address;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.accent : Colors.transparent,
                border: Border.all(color: selected ? AppColors.accent : AppColors.divider, width: 2),
              ),
              child: selected ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                address.text,
                style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.edit, size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _AddAddressForm extends StatelessWidget {
  const _AddAddressForm({required this.onCancel, required this.onSubmit});
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Grabber(),
          Row(
            children: [
              TextButton(
                onPressed: onCancel,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Москва', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary),
                  ],
                ),
              ),
            ],
          ),
          const _FormField(hint: 'Город, улица и дом', initial: 'Народного Ополчения 47к1с1'),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _FormField(hint: 'Подъезд')),
              SizedBox(width: 8),
              Expanded(child: _FormField(hint: 'Код на двери')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _FormField(hint: 'Этаж')),
              SizedBox(width: 8),
              Expanded(child: _FormField(hint: 'Квартира/офис')),
            ],
          ),
          const SizedBox(height: 12),
          const _FormField(hint: 'Комментарии к адресу'),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Доставить сюда', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.hint, this.initial});
  final String hint;
  final String? initial;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: initial != null ? TextEditingController(text: initial) : null,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.divider)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
      ),
    );
  }
}

class _RestaurantSheet extends StatelessWidget {
  const _RestaurantSheet({
    required this.restaurant,
    required this.expanded,
    required this.onExpand,
    required this.onConfirm,
  });
  final Restaurant restaurant;
  final bool expanded;
  final VoidCallback onExpand;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return _SheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: onExpand,
            child: const _Grabber(),
          ),
          Center(child: Text(restaurant.city, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary))),
          const SizedBox(height: 4),
          Center(
            child: Text(
              restaurant.address,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Открыто ${restaurant.openUntil}',
                  style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.circle, size: 4, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                const Icon(Icons.send, size: 12, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${restaurant.kmAway} km', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(width: 6),
                const Icon(Icons.circle, size: 4, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text('${restaurant.minutesAway} min', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoRow(label: 'Phone', value: restaurant.phone),
          const Divider(height: 1, color: AppColors.divider),
          _InfoRow(label: 'График', value: restaurant.hours),
          if (expanded) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: restaurant.photos.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: restaurant.photos[i],
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(color: AppColors.divider),
                      errorWidget: (_, _, _) => Container(color: AppColors.divider),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ] else
            const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Заказать здесь', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
