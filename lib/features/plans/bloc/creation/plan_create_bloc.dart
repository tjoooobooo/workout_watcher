import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_week_model.dart';

import 'plan_create_event.dart';
import 'plan_create_state.dart';

class PlanCreateBloc extends Bloc<PlanCreateEvent, PlanCreateState> {
  PlanCreateBloc() : super(const PlanCreateState()) {
    on<InitialEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.initial));
    });

    on<StartedEditingEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.editing, plan: event.plan));
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
      emit(state.copyWith(status: PlanCreateStateStatus.updating));
      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.elementAt(state.dayIndex!);
      planDay.exercises.addAll(event.exerciseIds);
      plan.replaceDay(state.dayIndex!, planDay);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });

    on<DeleteExerciseFromDayEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.updating));
      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.elementAt(state.dayIndex!);
      planDay.exercises.remove(event.exerciseId);
      plan.replaceDay(state.dayIndex!, planDay);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });

    on<AddExceptionExerciseEvent>((event, emit) {
      emit(state.copyWith(status: PlanCreateStateStatus.updating));
      PlanExceptionExerciseModel exercise = event.exercise;

      PlanModel plan = state.plan!;
      PlanWeekModel planWeek = plan.planWeeks[event.weekNr]!;
      planWeek.addExceptionExercise(exercise);

      plan.replaceWeek(event.weekNr, planWeek);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });

    on<ReorderExerciseEvent>((event, emit) {
      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;

      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      emit(state.copyWith(status: PlanCreateStateStatus.updating));
      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.elementAt(state.dayIndex!);
      final String exercise = planDay.exercises.removeAt(oldIndex);
      planDay.exercises.insert(newIndex, exercise);
      plan.replaceDay(state.dayIndex!, planDay);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });

    on<ReorderDayEvent>((event, emit) {
      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;

      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      emit(state.copyWith(status: PlanCreateStateStatus.updating));
      PlanModel plan = state.plan!;
      PlanDayModel planDay = plan.planDays.removeAt(oldIndex);
      plan.planDays.insert(newIndex, planDay);
      emit(state.copyWith(status: PlanCreateStateStatus.updated, plan: plan));
    });
  }
}
