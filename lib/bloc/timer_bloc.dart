import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../ticker.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int> _streamSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_duration));

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapResumeToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTickerToState(event);
    } else if (event is TimerReset) {
      yield* _mapResetToState(event);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapStartedToState(TimerStarted start) async* {
    yield TimerInProgress(start.duration);
    _streamSubscription?.cancel();
    _streamSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapPausedToState(TimerPaused pause) async* {
    if (state is TimerInProgress) {
      _streamSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapResumeToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _streamSubscription?.resume();
      yield TimerInProgress(state.duration);
    }
  }

  Stream<TimerState> _mapResetToState(TimerReset reset) async* {
    _streamSubscription.cancel();
    yield TimerInitial(_duration);
  }

  Stream<TimerState> _mapTickerToState(TimerTicked ticked) async* {
    yield ticked.duration > 0
        ? TimerInProgress(ticked.duration)
        : TimerRunComplete();
  }
}
