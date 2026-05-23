import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    this.token,
    this.phone,
    this.name,
    this.email,
    this.coins = 305,
  });

  final String? token;
  final String? phone;
  final String? name;
  final String? email;
  final int coins;

  bool get isLoggedIn => token != null;

  AuthState copyWith({
    String? token,
    String? phone,
    String? name,
    String? email,
    bool clearToken = false,
  }) =>
      AuthState(
        token: clearToken ? null : (token ?? this.token),
        phone: clearToken ? null : (phone ?? this.phone),
        name: clearToken ? null : (name ?? this.name),
        email: clearToken ? null : (email ?? this.email),
        coins: coins,
      );

  @override
  List<Object?> get props => [token, phone, name, email, coins];
}
