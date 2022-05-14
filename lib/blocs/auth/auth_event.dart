part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String password;
  final String email;

  const LoginEvent({required this.password, required this.email});
  @override
  String toString() => 'LoginEvent';

  @override
  List<Object?> get props => [password, email];
}
