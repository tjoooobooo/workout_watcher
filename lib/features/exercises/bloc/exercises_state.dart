import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:workout_watcher/Models/Exercise.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';

enum ExerciseStateStatus { initial, loading, loaded, loadedExercise, error, updating }

extension ExerciseStateStatusX on ExerciseStateStatus {
  bool get isInitial => this == ExerciseStateStatus.initial;

  bool get isLoading => this == ExerciseStateStatus.loading;

  bool get isLoaded => this == ExerciseStateStatus.loaded;

  bool get isLoadedExercise => this == ExerciseStateStatus.loadedExercise;

  bool get isError => this == ExerciseStateStatus.error;

  bool get isUpdating => this == ExerciseStateStatus.updating;
}

@immutable
class ExerciseState extends Equatable {
  final ExerciseStateStatus status;
  final List<ExerciseModel> exercises;
  final ExerciseModel? exercise;

  const ExerciseState(
      {this.status = ExerciseStateStatus.loading,
      this.exercises = const [],
      this.exercise});

  @override
  List<Object> get props {
    if (exercise == null) {
      return [status, exercises];
    } else {
      return [status, exercises, exercise!];
    }
  }

  ExerciseState copyWith(
      {ExerciseStateStatus? status,
      List<ExerciseModel>? exercises,
      ExerciseModel? exercise}) {
    return ExerciseState(
        status: status ?? this.status,
        exercises: exercises ?? [],
        exercise: exercise);
  }
}
