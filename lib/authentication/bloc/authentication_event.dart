part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChaged extends AuthenticationEvent {
  final AuthStatus status;
  const AuthStatusChaged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthLogoutREquest extends AuthenticationEvent {}
