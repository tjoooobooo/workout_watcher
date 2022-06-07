import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logInfo("Event: " + event.toString());
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logInfo("-------- Change start -------- \n"
        "Current: " + change.currentState.toString() + "\n"
        "Next: " + change.nextState.toString() + "\n"
        "--------- Change end --------- \n"
    );
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logInfo(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logInfo("-------- Transition start -------- \n"
        "Current: " + transition.currentState.toString() + "\n"
        "Event: " + transition.event.toString() + "\n"
        "Next: " + transition.nextState.toString() + "\n"
        "--------- Transition end --------- \n"
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logInfo("Error: " + stackTrace.toString());
  }
}
