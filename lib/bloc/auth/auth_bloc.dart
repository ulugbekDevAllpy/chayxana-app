import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? repository})
      : _repo = repository ?? AuthRepository(),
        super(const AuthState()) {
    on<AuthLoadRequested>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      emit(AuthState(
        token: prefs.getString(_kToken),
        phone: prefs.getString(_kPhone),
        name: prefs.getString(_kName),
        email: prefs.getString(_kEmail),
      ));
    });

    on<AuthSignInRequested>((event, emit) async {
      final result = await _repo.login(phone: event.phone, password: '');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kToken, result.token);
      await prefs.setString(_kPhone, result.phone);
      emit(state.copyWith(token: result.token, phone: result.phone));
    });

    on<AuthProfileUpdated>((event, emit) async {
      await _repo.updateProfile(name: event.name, email: event.email);
      final prefs = await SharedPreferences.getInstance();
      if (event.name != null) await prefs.setString(_kName, event.name!);
      if (event.email != null) await prefs.setString(_kEmail, event.email!);
      emit(state.copyWith(name: event.name, email: event.email));
    });

    on<AuthSignedOut>((event, emit) async {
      await _repo.logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kToken);
      await prefs.remove(_kPhone);
      await prefs.remove(_kName);
      await prefs.remove(_kEmail);
      emit(state.copyWith(clearToken: true));
    });
  }

  final AuthRepository _repo;

  static const _kToken = 'auth.token';
  static const _kPhone = 'auth.phone';
  static const _kName = 'auth.name';
  static const _kEmail = 'auth.email';
}
