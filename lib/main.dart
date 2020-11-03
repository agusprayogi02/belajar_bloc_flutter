import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:pdam/app.dart';
import 'package:pdam/counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}
