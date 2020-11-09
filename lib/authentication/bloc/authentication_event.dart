part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChaged extends AuthenticationEvent {
  const AuthStatusChaged(this.status);
  final AuthStatus status;

  @override
  List<Object> get props => [status];
}

class AuthLogoutREquest extends AuthenticationEvent {}
