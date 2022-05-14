part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthInProgress extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthCompleted extends AuthState {
  const AuthCompleted(this.response);
  final ScreenSaverMastersResponse response;
  @override
  List<Object> get props => [response];
}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);
  @override
  List<Object> get props => [];
}
