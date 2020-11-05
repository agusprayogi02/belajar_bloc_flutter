import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdam/bloc/post_bloc.dart';
import 'package:pdam/component/botton_loader.dart';
import 'package:pdam/component/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scollController = ScrollController();
  final _scollThesHold = 200.0;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scollController.addListener(_onScoll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  void _onScoll() {
    final maxScroll = _scollController.position.maxScrollExtent;
    final currentScoll = _scollController.position.pixels;
    if (maxScroll - currentScoll <= _scollThesHold) {
      _postBloc.add(PostFected());
    }
  }

  @override
  void dispose() {
    _scollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle h3 = Theme.of(context).textTheme.headline3;
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Loading...",
                style: h3,
              )
            ],
          );
        }
        if (state is PostFailure) {
          return Center(
            child: Text(
              "failed to load Api",
              style: h3,
            ),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text(
                "No Post",
                style: h3,
              ),
            );
          }
          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottonLoader()
                  : PostWidget(
                      post: state.posts[index],
                    );
            },
            controller: _scollController,
          );
        }
        return Center();
      },
    );
  }
}
