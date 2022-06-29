import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/plans/domain/repositories/plan_repository.dart';

import 'plan_create_event.dart';
import 'plan_create_state.dart';

class PlanCreateBloc extends Bloc<PlanCreateEvent, PlanCreateState> {
  PlanCreateBloc() : super(const PlanCreateState(status: PlanCreateStateStatus.initial)) {
    on<StartedEditingEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.initial, plan: event.plan));
    });

    on<UpdatePlanCreateEvent>((event, emit) {
      if (state.plan != null) {
        emit(state.copyWith(
            status: PlanCreateStateStatus.updated, plan: state.plan!.copyWith(name: event.name)));
      }
    });

    on<SwitchDayEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.switchDay, dayIndex: event.selectedDay));
    });

    on<SwitchedDayEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.switchedDay));
    });

    on<ChangeDayNameEvent>((event, emit) {});
  }
}
