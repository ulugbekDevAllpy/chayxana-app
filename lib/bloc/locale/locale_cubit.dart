import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ru'));

  static const _kLocale = 'app.locale';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kLocale);
    if (code != null && _supported.contains(code)) {
      emit(Locale(code));
    }
  }

  Future<void> set(Locale locale) async {
    if (!_supported.contains(locale.languageCode)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocale, locale.languageCode);
    emit(locale);
  }

  static const _supported = ['en', 'ru', 'uz'];
}
