import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdam/model/post.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client client;
  PostBloc({@required this.client}) : super(PostInitial());

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.timeout(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    final currentState = state;
    if (event is PostFected && !_hasReactedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await _fecthPost(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await _fecthPost(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    }
  }

  bool _hasReactedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;

  Future<List<Post>> _fecthPost(int startIndex, int limit) async {
    final respon = await http.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (respon.statusCode == 200) {
      final data = json.encode(respon.body) as List;
      return data.map<Post>((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
