import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdam/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pdam/bloc_observer.dart';
import 'package:pdam/view/home_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Posts'),
          ),
          body: BlocProvider(
            create: (context) =>
                PostBloc(client: http.Client())..add(PostFected()),
            child: HomePage(),
          )),
    );
  }
}
