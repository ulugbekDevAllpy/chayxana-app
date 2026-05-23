import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WaiterCallSheet {
  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _WaiterCallSheetBody(),
    );
  }
}

class _WaiterCallSheetBody extends StatefulWidget {
  const _WaiterCallSheetBody();

  @override
  State<_WaiterCallSheetBody> createState() => _WaiterCallSheetBodyState();
}

class _WaiterCallSheetBodyState extends State<_WaiterCallSheetBody> {
  static const _tables = [
    '1', '2', '3', '4', '5', '6А', '6Б', '7', '8',
    '10', '11', '12А', '12Б', '14', '15', '16', '20', 'VIP-1', 'VIP-2',
  ];

  String? _table;
  bool _bringMenu = false;
  bool _bringBill = false;

  bool get _canSubmit => _table != null && (_bringMenu || _bringBill);

  void _showTableSelector() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: SizedBox(
          height: 360,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Номер вашего стола', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              const Divider(height: 1, color: AppColors.divider),
              Expanded(
                child: ListView.separated(
                  itemCount: _tables.length,
                  separatorBuilder: (_, _) => const Divider(height: 1, color: AppColors.divider),
                  itemBuilder: (_, i) => ListTile(
                    title: Text(_tables[i]),
                    onTap: () => Navigator.of(context).pop(_tables[i]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) {
      setState(() => _table = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 32),
                    const Expanded(
                      child: Center(
                        child: Text('Позвать официанта', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: AppColors.divider,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Выберите номер вашего стола',
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: _showTableSelector,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.divider)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _table ?? 'номер стола',
                            style: TextStyle(
                              fontSize: 16,
                              color: _table != null ? AppColors.textPrimary : AppColors.textSecondary,
                              fontWeight: _table != null ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _OptionRow(
                  label: 'Принести меню',
                  selected: _bringMenu,
                  onTap: () => setState(() => _bringMenu = !_bringMenu),
                ),
                _OptionRow(
                  label: 'Принести счёт',
                  selected: _bringBill,
                  onTap: () => setState(() => _bringBill = !_bringBill),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? () => Navigator.of(context).pop(true) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.35),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text('Вызвать', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

class _OptionRow extends StatelessWidget {
  const _OptionRow({required this.label, required this.selected, required this.onTap});
  final String label;
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
                border: Border.all(
                  color: selected ? AppColors.accent : AppColors.divider,
                  width: 2,
                ),
              ),
              child: selected ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 15, color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }
}
