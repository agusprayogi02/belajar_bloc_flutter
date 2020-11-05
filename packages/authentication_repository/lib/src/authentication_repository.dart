import 'dart:async';

import 'package:meta/meta.dart';

enum AuthStatus { unknown, authenticeted, unauthenticeted }

class AuthRepo {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticeted;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    await Future.delayed(
      const Duration(microseconds: 300),
      () => _controller.add(AuthStatus.authenticeted),
    );
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticeted);
  }

  void dispose() => _controller.close();
}
