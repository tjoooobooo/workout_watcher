import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';

@immutable
abstract class ExercisesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingExercisesEvent extends ExercisesEvent {}

class GetAllExercisesEvent extends ExercisesEvent {
  final bool refreshCache;

  GetAllExercisesEvent({this.refreshCache = false});

  @override
  List<Object> get props => [refreshCache];
}

class GetExerciseEvent extends ExercisesEvent {
  final String id;

  GetExerciseEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchExercisesEvent extends ExercisesEvent {
  final String search;

  SearchExercisesEvent(this.search);

  @override
  List<Object> get props => [search];
}

class AddExerciseEvent extends ExercisesEvent {
  final ExerciseModel exercise;

  AddExerciseEvent(this.exercise);

  @override
  List<Object> get props => [exercise];
}

class UpdateExerciseEvent extends ExercisesEvent {
  final ExerciseModel exercise;

  UpdateExerciseEvent(this.exercise);

  @override
  List<Object> get props => [exercise];
}

class UpdatingExerciseEvent extends ExercisesEvent {}

class DeleteExerciseEvent extends ExercisesEvent {
  final String exerciseId;

  DeleteExerciseEvent(this.exerciseId);

  @override
  List<Object> get props => [exerciseId];
}

class LoadedExercisesEvent extends ExercisesEvent {
  final List<ExerciseModel> exercises;

  LoadedExercisesEvent(this.exercises);

  @override
  List<Object> get props => [exercises];
}