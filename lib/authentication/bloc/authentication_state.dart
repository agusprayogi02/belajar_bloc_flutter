part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState._({this.status = AuthStatus.unknown, this.user});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthStatus.authenticeted, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthStatus.unauthenticeted);

  final AuthStatus status;
  final User user;

  @override
  List<Object> get props => [];
}
