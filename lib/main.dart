import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdam/bloc/timer_bloc.dart';
import 'package:pdam/ticker.dart';
import 'view/timer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color.fromRGBO(109, 234, 255, 1),
          accentColor: Color.fromRGBO(72, 74, 126, 1),
          brightness: Brightness.dark,
        ),
        title: "Flutter Timer",
        home: BlocProvider(
          create: (_) => TimerBloc(
            ticker: Ticker(),
          ),
          child: TimerPage(),
        ));
  }
}
