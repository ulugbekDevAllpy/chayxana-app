import 'package:flutter/material.dart';

import '../models/menu_item.dart';
import '../theme/app_theme.dart';

class ShareSheet {
  static Future<void> show(BuildContext context, {required MenuItem item}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ShareSheetBody(item: item),
    );
  }
}

class _ShareSheetBody extends StatelessWidget {
  const _ShareSheetBody({required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.local_cafe, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Чайхана Ташкент Сити',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close, size: 22),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E5EA)),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                children: const [
                  _AppIcon(label: 'AirDrop', icon: Icons.wifi_tethering, color: Colors.blue),
                  _AppIcon(label: 'Messages', icon: Icons.message, color: Colors.green),
                  _AppIcon(label: 'Mail', icon: Icons.mail, color: Color(0xFF1976D2)),
                  _AppIcon(label: 'Notes', icon: Icons.sticky_note_2, color: Colors.amber),
                  _AppIcon(label: 'Reminders', icon: Icons.checklist, color: Colors.redAccent),
                  _AppIcon(label: 'Telegram', icon: Icons.send, color: Color(0xFF229ED9)),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE5E5EA)),
            _SheetTile(label: 'Copy', icon: Icons.copy, onTap: () => Navigator.of(context).maybePop()),
            const Divider(height: 1, indent: 56, color: Color(0xFFE5E5EA)),
            _SheetTile(label: 'Add to Reading List', icon: Icons.menu_book, onTap: () => Navigator.of(context).maybePop()),
            const Divider(height: 1, indent: 56, color: Color(0xFFE5E5EA)),
            _SheetTile(label: 'Add to Favorites', icon: Icons.bookmark_add, onTap: () => Navigator.of(context).maybePop()),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.label, required this.icon, required this.color});
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  const _SheetTile({required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Icon(icon, color: AppColors.textPrimary, size: 22),
          ],
        ),
      ),
    );
  }
}
