part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPause extends TimerState {
  TimerRunPause(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerRunPause { duration: $duration }';
  }
}

class TimerInProgress extends TimerState {
  TimerInProgress(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerInProgress { duration: $duration }';
  }
}

class TimerRunComplete extends TimerState {
  TimerRunComplete() : super(0);
}
