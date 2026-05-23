import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _name;
  late final TextEditingController _email;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthBloc>().state;
    _phone = TextEditingController(text: auth.phone ?? '+7');
    _name = TextEditingController(text: auth.name ?? '');
    _email = TextEditingController(text: auth.email ?? '');
    for (final c in [_name, _email]) {
      c.addListener(() => setState(() => _dirty = true));
    }
  }

  @override
  void dispose() {
    _phone.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void _save() {
    context.read<AuthBloc>().add(AuthProfileUpdated(name: _name.text, email: _email.text));
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL10n.of(context);
    return Scaffold(
      backgroundColor: AppColors.creamSoft,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 16, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UnderlineField(label: l.phoneLabel, controller: _phone, keyboardType: TextInputType.phone),
                    UnderlineField(label: l.nameLabel, controller: _name),
                    UnderlineField(label: l.emailLabel, controller: _email),
                  ],
                ),
              ),
            ),
            if (_dirty)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: PrimaryButton(label: l.save, onPressed: _save),
              ),
          ],
        ),
      ),
    );
  }
}
