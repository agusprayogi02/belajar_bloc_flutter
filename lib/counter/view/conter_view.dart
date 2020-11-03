import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdam/counter/cubit/counter_cubit.dart';

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Center(
        child: BlocBuilder(
          builder: (context, state) {
            return Text(
              "$state",
              style: textTheme.headline2,
            );
          },
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            key: Key("Minus"),
            child: Icon(Icons.remove),
            onPressed: () => context.bloc<CounterCubit>().decrement(),
          ),
          FloatingActionButton(
            key: Key("Plus"),
            child: Icon(Icons.add),
            onPressed: () => context.bloc<CounterCubit>().increment(),
          )
        ],
      ),
    );
  }
}
