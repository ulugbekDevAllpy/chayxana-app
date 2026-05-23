import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoadRequested extends AuthEvent {
  const AuthLoadRequested();
}

class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested(this.phone);
  final String phone;
  @override
  List<Object?> get props => [phone];
}

class AuthProfileUpdated extends AuthEvent {
  const AuthProfileUpdated({this.name, this.email});
  final String? name;
  final String? email;
  @override
  List<Object?> get props => [name, email];
}

class AuthSignedOut extends AuthEvent {
  const AuthSignedOut();
}
