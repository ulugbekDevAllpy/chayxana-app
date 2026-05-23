import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/mock_map.dart';
import 'rate_order_screen.dart';

enum _Stage { accepted, cooking, delivering, delivered }

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  _Stage _stage = _Stage.accepted;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      setState(() {
        switch (_stage) {
          case _Stage.accepted:
            _stage = _Stage.cooking;
          case _Stage.cooking:
            _stage = _Stage.delivering;
          case _Stage.delivering:
            _stage = _Stage.delivered;
          case _Stage.delivered:
            _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _title => switch (_stage) {
        _Stage.accepted => 'Приняли ваш заказ',
        _Stage.cooking => 'Готовим ваше блюдо',
        _Stage.delivering => 'Доставим через 8 минут',
        _Stage.delivered => 'Ваше блюдо доставлено',
      };

  String get _subtitle => switch (_stage) {
        _Stage.accepted => 'Заказ будет доставлен в течение 30 минут',
        _Stage.cooking => 'Ваш заказ будет доставлен в течение 30 минут',
        _Stage.delivering => 'Курьер Алишер забрал заказ и направляется к вам',
        _Stage.delivered => '',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        child: Column(
          children: [
            _Header(onClose: () => Navigator.of(context).maybePop()),
            Expanded(
              child: Stack(
                children: [
                  const Positioned.fill(child: MockMap()),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Row(
                      children: const [
                        MapPin(color: AppColors.primary, icon: Icons.local_cafe, size: 36),
                        SizedBox(width: 4),
                        MapPin(color: AppColors.accent, icon: Icons.pedal_bike, size: 36),
                      ],
                    ),
                  ),
                  if (_stage == _Stage.delivering || _stage == _Stage.cooking)
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.4,
                      top: MediaQuery.of(context).size.height * 0.3,
                      child: const MapPin(color: AppColors.accent, icon: Icons.pedal_bike, size: 44),
                    ),
                  Positioned(
                    right: 40,
                    bottom: 40,
                    child: const MapPin(color: AppColors.primary, icon: Icons.flag, size: 44),
                  ),
                ],
              ),
            ),
            _BottomPanel(
              title: _title,
              subtitle: _subtitle,
              stage: _stage,
              onCancel: () => Navigator.of(context).maybePop(),
              onContact: () {},
              onCallCourier: () {},
              onFinish: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const RateOrderScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Заказ №28 в 10:50',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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

class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    required this.title,
    required this.subtitle,
    required this.stage,
    required this.onCancel,
    required this.onContact,
    required this.onCallCourier,
    required this.onFinish,
  });

  final String title;
  final String subtitle;
  final _Stage stage;
  final VoidCallback onCancel;
  final VoidCallback onContact;
  final VoidCallback onCallCourier;
  final VoidCallback onFinish;

  int get _stageIndex => _Stage.values.indexOf(stage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.creamSoft,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < 4; i++)
                _StageDot(
                  icon: switch (i) {
                    0 => Icons.check,
                    1 => Icons.restaurant,
                    2 => Icons.pedal_bike,
                    _ => Icons.flag,
                  },
                  active: i <= _stageIndex,
                  current: i == _stageIndex,
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if (stage == _Stage.accepted)
                Expanded(child: _OutlineBtn(label: 'Отменить заказ', onTap: onCancel)),
              if (stage == _Stage.accepted) const SizedBox(width: 8),
              if (stage == _Stage.delivering)
                Expanded(child: _OutlineBtn(label: 'Позвонить курьеру', onTap: onCallCourier)),
              if (stage == _Stage.delivering) const SizedBox(width: 8),
              if (stage != _Stage.delivered)
                Expanded(child: _OutlineBtn(label: 'Связаться с нами', onTap: onContact)),
              if (stage == _Stage.delivered) ...[
                Expanded(child: _OutlineBtn(label: 'Позвонить курьеру', onTap: onCallCourier)),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onFinish,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    child: const Text('Оценить'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StageDot extends StatelessWidget {
  const _StageDot({required this.icon, required this.active, required this.current});
  final IconData icon;
  final bool active;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.accent : AppColors.accent.withValues(alpha: 0.3);
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: current ? Border.all(color: AppColors.primary, width: 2) : null,
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  const _OutlineBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.divider),
        backgroundColor: AppColors.card,
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}
