import 'package:enum_to_string/enum_to_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_state.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/exercises/domain/repositorys/exercise_repository.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExercisesBloc(this.exerciseRepository)
      : super(const ExerciseState(status: ExerciseStateStatus.initial)) {
    on<GetAllExercisesEvent>((event, emit) async {
      final exercises =
          await exerciseRepository.getAllExercises(event.refreshCache);
      exercises.fold(
          (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
          (success) => emit(state.copyWith(
              status: ExerciseStateStatus.loaded, exercises: success)));
    });

    on<GetExerciseEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));

      final exercise = await exerciseRepository.getExercise(event.id);

      exercise.fold(
          (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
          (success) => emit(state.copyWith(
              status: ExerciseStateStatus.loadedExercise, exercise: success)));
    });

    on<LoadingExercisesEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));
    });

    on<SearchExercisesEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));

      final exercises = await exerciseRepository.searchExercises(event.search);

      exercises.fold(
          (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
          (success) => emit(state.copyWith(
              status: ExerciseStateStatus.loaded, exercises: success)));
    });

    on<LoadedExercisesEvent>((event, emit) async {
      emit(state.copyWith(
          status: ExerciseStateStatus.loaded, exercises: event.exercises));
    });

    on<AddExerciseEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));

      final addedExercise =
          await exerciseRepository.addExercise(event.exercise);

      addedExercise.fold(
          (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
          (success) => add(GetAllExercisesEvent(refreshCache: true)));
    });

    on<UpdateExerciseEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));

      final addedExercise = await exerciseRepository.updateExercise(event.exercise);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
              (success) => add(GetAllExercisesEvent(refreshCache: true)));
    });

    on<DeleteExerciseEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.loading));

      final addedExercise = await exerciseRepository.deleteExercise(event.exerciseId);

      addedExercise.fold(
              (failure) => emit(state.copyWith(status: ExerciseStateStatus.error)),
              (success) => add(GetAllExercisesEvent(refreshCache: true)));
    });

    on<UpdatingExerciseEvent>((event, emit) async {
      emit(state.copyWith(status: ExerciseStateStatus.updating));
    });
  }
}
