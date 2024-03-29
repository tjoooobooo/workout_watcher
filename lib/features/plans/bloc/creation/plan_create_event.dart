import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_state.dart';
import 'package:workout_watcher/features/plans/data/models/plan_day_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_exception_exercise.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';
import 'package:workout_watcher/features/plans/data/models/plan_week_model.dart';

@immutable
abstract class PlanCreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends PlanCreateEvent {}

class StartedEditingEvent extends PlanCreateEvent {
  final PlanModel plan;

  StartedEditingEvent({required this.plan});

  @override
  List<Object> get props => [plan];
}

class UpdatePlanCreateEvent extends PlanCreateEvent {
  final String? name;
  final int? cycles;
  final int? units;
  final PlanModelStates? state;
  final List<PlanDayModel>? planDays;
  final Map<int, PlanWeekModel>? planWeeks;

  UpdatePlanCreateEvent({this.name, this.cycles, this.units, this.state, this.planDays, this.planWeeks});

  @override
  List<Object?> get props => [name, cycles, units, state, planDays, planWeeks];
}

class ChangeDayNameEvent extends PlanCreateEvent {
  final int index;
  final String name;

  ChangeDayNameEvent({required this.index, required this.name});

  @override
  List<Object> get props => [index, name];
}

class SwitchDayEvent extends PlanCreateEvent {
  final int selectedDay;

  SwitchDayEvent({required this.selectedDay});

  @override
  List<Object> get props => [selectedDay];
}

class SwitchedDayEvent extends PlanCreateEvent {}

class AddExercisesToDayEvent extends PlanCreateEvent {
  final List<String> exerciseIds;

  AddExercisesToDayEvent({required this.exerciseIds});

  @override
  List<Object> get props => [exerciseIds];
}

class DeleteExerciseFromDayEvent extends PlanCreateEvent {
  final String exerciseId;

  DeleteExerciseFromDayEvent({required this.exerciseId});

  @override
  List<Object> get props => [exerciseId];
}

class AddExceptionExerciseEvent extends PlanCreateEvent {
  final PlanExceptionExerciseModel exercise;
  final int weekNr;

  AddExceptionExerciseEvent({required this.exercise, required this.weekNr});

  @override
  List<Object> get props => [exercise, weekNr];
}

class ReorderExerciseEvent extends PlanCreateEvent {
  final int oldIndex;
  final int newIndex;

  ReorderExerciseEvent({required this.oldIndex, required this.newIndex});

  @override
  List<Object> get props => [oldIndex, newIndex];
}

class ReorderDayEvent extends PlanCreateEvent {
  final int oldIndex;
  final int newIndex;

  ReorderDayEvent({required this.oldIndex, required this.newIndex});

  @override
  List<Object> get props => [oldIndex, newIndex];
}