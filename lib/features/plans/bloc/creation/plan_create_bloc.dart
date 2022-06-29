import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
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
            status: PlanCreateStateStatus.updated,
            plan:
                state.plan!.copyWith(name: event.name, units: event.units, cycles: event.cycles)));
      }
    });

    on<SwitchDayEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.switchDay, dayIndex: event.selectedDay));
    });

    on<SwitchedDayEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.switchedDay));
    });

    on<ChangeDayNameEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.updating));

      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.elementAt(event.index);
      if (event.name != planDay.name) {
        PlanDayModel newPlanDay = planDay.copyWith(name: event.name);
        plan.replaceDay(event.index, newPlanDay);
        emit(state.copyWith(status: PlanCreateStateStatus.changedDayName, plan: plan));
      }
    });
  }
}
