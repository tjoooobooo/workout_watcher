import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

import 'plan_create_event.dart';
import 'plan_create_state.dart';

class PlanCreateBloc extends HydratedBloc<PlanCreateEvent, PlanCreateState> {
  PlanCreateBloc() : super(const PlanCreateState()) {
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
      emit(state.copyWith(
          status: PlanCreateStateStatus.switchDay,
          dayIndex: event.selectedDay,
          isCurrentlySwitchingDay: true));
    });

    on<SwitchedDayEvent>((event, emit) {
      emit(state.copyWith(
          status: PlanCreateStateStatus.switchedDay, isCurrentlySwitchingDay: false));
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

    on<AddExercisesToDayEvent>((event, emit) {
      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.elementAt(state.dayIndex!);
      planDay.exercises.addAll(event.exerciseIds);
      plan.replaceDay(state.dayIndex!, planDay);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });
  }

  @override
  PlanCreateState? fromJson(Map<String, dynamic> json) {
    return PlanCreateState(
        status: EnumToString.fromString(PlanCreateStateStatus.values, json['status'])!,
        plan: PlanModel.fromMap(json['plan']),
        dayIndex: json['dayIndex']);
  }

  @override
  Map<String, dynamic>? toJson(PlanCreateState state) {
    return {
      'status': EnumToString.convertToString(state.status),
      'dayIndex': state.dayIndex,
      'plan': state.plan!.toJSON()
    };
  }
}
