import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../counter.dart';

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          left: 35,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              key: const Key("Minus"),
              child: const Icon(Icons.remove),
              onPressed: () => context.bloc<CounterCubit>().decrement(),
            ),
            FloatingActionButton(
              key: const Key("Plus"),
              child: const Icon(Icons.add),
              onPressed: () => context.bloc<CounterCubit>().increment(),
            )
          ],
        ),
      ),
    );
  }
}
