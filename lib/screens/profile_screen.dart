import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart' as auth;
import '../bloc/locale/locale_cubit.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'about_screen.dart';
import 'auth/onboarding_screen.dart';
import 'bonuses_screen.dart';
import 'invite_friend_screen.dart';
import 'orders_screen.dart';
import 'profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.3),
        transitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => screen,
        transitionsBuilder: (_, anim, _, child) {
          final t = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(t),
            child: child,
          );
        },
      ),
    );
  }

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.4),
        transitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => const ProfileScreen(),
        transitionsBuilder: (_, anim, _, child) {
          final t = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(t),
            child: child,
          );
        },
      ),
    );
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final l = AppL10n.of(context);
    final cubit = context.read<LocaleCubit>();
    final current = cubit.state.languageCode;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 12),
              Text(l.language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              for (final code in const ['ru', 'en', 'uz'])
                _LangTile(
                  code: code,
                  label: switch (code) {
                    'ru' => l.languageRussian,
                    'en' => l.languageEnglish,
                    'uz' => l.languageUzbek,
                    _ => code,
                  },
                  selected: code == current,
                  onTap: () {
                    cubit.set(Locale(code));
                    Navigator.of(sheetContext).maybePop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.creamSoft,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _Header(onClose: () => Navigator.of(context).maybePop()),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const _CoinsCard(),
                        const SizedBox(height: 14),
                        _MenuList(
                          onTapPersonal: () => _push(context, const ProfileEditScreen()),
                          onTapBonuses: () => _push(context, const BonusesScreen()),
                          onTapOrders: () => _push(context, const OrdersScreen()),
                          onTapInvite: () => _push(context, const InviteFriendScreen()),
                          onTapAbout: () => _push(context, const AboutScreen()),
                          onTapLanguage: () => _showLanguagePicker(context),
                          onTapLogout: () {
                            context.read<AuthBloc>().add(const AuthSignedOut());
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                              (_) => false,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const _DeleteAccount(),
                        const SizedBox(height: 24),
                      ],
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

class _LangTile extends StatelessWidget {
  const _LangTile({required this.code, required this.label, required this.selected, required this.onTap});
  final String code;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
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
            Text(label, style: const TextStyle(fontSize: 15)),
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
    final l = AppL10n.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
      child: Row(
        children: [
          const SizedBox(width: 36),
          Expanded(
            child: Center(
              child: Text(l.profile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

class _CoinsCard extends StatelessWidget {
  const _CoinsCard();

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return BlocBuilder<AuthBloc, auth.AuthState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE3973A), Color(0xFFD08423)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(opacity: 0.18, child: CustomPaint(painter: _OrnamentPainter())),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${state.coins}',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.savings, color: Colors.white, size: 22),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      l.bonus3Percent,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrnamentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 0; i < 12; i++) {
      final r = i * 16.0 + 10;
      canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.5), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MenuList extends StatelessWidget {
  const _MenuList({
    required this.onTapPersonal,
    required this.onTapBonuses,
    required this.onTapOrders,
    required this.onTapInvite,
    required this.onTapAbout,
    required this.onTapLanguage,
    required this.onTapLogout,
  });
  final VoidCallback onTapPersonal;
  final VoidCallback onTapBonuses;
  final VoidCallback onTapOrders;
  final VoidCallback onTapInvite;
  final VoidCallback onTapAbout;
  final VoidCallback onTapLanguage;
  final VoidCallback onTapLogout;

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _ProfileMenuItem(icon: Icons.savings, label: l.personalData, onTap: onTapPersonal),
          _ProfileMenuItem(icon: Icons.cookie_outlined, label: l.bonuses, onTap: onTapBonuses),
          _ProfileMenuItem(icon: Icons.location_on, label: l.addressesMenuItem, onTap: () {}),
          _ProfileMenuItem(icon: Icons.receipt_long, label: l.orderHistory, onTap: onTapOrders),
          _ProfileMenuItem(icon: Icons.group_outlined, label: l.inviteFriend, onTap: onTapInvite),
          _ProfileMenuItem(icon: Icons.chat_bubble_outline, label: l.support, onTap: () {}),
          _ProfileMenuItem(icon: Icons.local_cafe_outlined, label: l.aboutChayxana, onTap: onTapAbout),
          _ProfileMenuItem(icon: Icons.language, label: l.language, onTap: onTapLanguage),
          _ProfileMenuItem(icon: Icons.logout, label: l.logout, onTap: onTapLogout),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteAccount extends StatelessWidget {
  const _DeleteAccount();

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: Text(
                l.deleteAccount,
                style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
