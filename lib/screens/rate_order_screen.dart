import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RateOrderScreen extends StatefulWidget {
  const RateOrderScreen({super.key});

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  int _rating = 0;
  final Set<String> _topics = {};
  final TextEditingController _comment = TextEditingController();

  static const _badTopics = ['Доставка не пришла во время!', 'Холодная еда', 'Грубый курьер'];
  static const _goodTopics = [
    'Отличный курьер',
    'Учли все пожелания',
    'Идеально собрали заказ',
    'Быстро привезли',
  ];

  List<String> get _currentTopics => _rating >= 4 ? _goodTopics : _badTopics;
  bool get _canSubmit => _rating > 0;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      pageBuilder: (_, _, _) => Center(
        child: Material(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 300,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accent, width: 3),
                  ),
                  child: const Icon(Icons.check, color: AppColors.accent, size: 40),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Спасибо за ваш отзыв!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Каждый отзыв помогает нам улучшать\nкачество обслуживания',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.creamSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Оцените заказ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => GestureDetector(
                      onTap: () => setState(() {
                        _rating = i + 1;
                        _topics.clear();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.star_rounded,
                          size: 44,
                          color: i < _rating ? AppColors.accent : AppColors.divider,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_rating > 0) ...[
                  const SizedBox(height: 18),
                  Text(
                    _rating >= 4 ? 'Что понравилось?' : 'Что не понравилось?',
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final t in _currentTopics)
                        _TopicChip(
                          label: t,
                          selected: _topics.contains(t),
                          onTap: () => setState(() {
                            if (_topics.contains(t)) {
                              _topics.remove(t);
                            } else {
                              _topics.add(t);
                            }
                          }),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 18),
                TextField(
                  controller: _comment,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Расскажите, что не понравилось. Передадим\nвашу жалобу по адресу',
                    hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    filled: true,
                    fillColor: AppColors.card,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.35),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text(
                      'Готово',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
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

class _TopicChip extends StatelessWidget {
  const _TopicChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.accent : AppColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
