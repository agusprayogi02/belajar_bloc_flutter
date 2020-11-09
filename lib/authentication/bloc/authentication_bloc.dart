import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {@required AuthRepo authRepo, @required UserRepository userRepository})
      : assert(authRepo != null),
        assert(userRepository != null),
        _authRepo = authRepo,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _streamSubscriptionStatus = _authRepo.status.listen(
      (status) => add(AuthStatusChaged(status)),
    );
  }

  final AuthRepo _authRepo;
  final UserRepository _userRepository;
  StreamSubscription<AuthStatus> _streamSubscriptionStatus;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthStatusChaged) {
      yield await _mapAuthStatusChangedToState(event);
    } else if (event is AuthLogoutREquest) {
      _authRepo.logOut();
    }
  }

  @override
  Future<void> close() {
    _streamSubscriptionStatus?.cancel();
    _authRepo.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthStatusChangedToState(
    AuthStatusChaged event,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticeted:
        return const AuthenticationState.unauthenticated();
      case AuthStatus.unauthenticeted:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
