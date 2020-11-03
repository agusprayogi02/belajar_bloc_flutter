import 'package:bloc/bloc.dart';

class CounterObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(cubit, error, stacktrace);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType} $change");
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
  }
}
