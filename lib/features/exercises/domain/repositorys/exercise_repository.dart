import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, List<ExerciseModel>>> getAllExercises(bool refreshCache);

  Future<Either<Failure, ExerciseModel>> getExercise(String id);

  Future<Either<Failure, List<ExerciseModel>>> searchExercises(String term);

  Future<Either<Failure, void>> addExercise(ExerciseModel exercise);

  Future<Either<Failure, void>> updateExercise(ExerciseModel exercise);

  Future<Either<Failure, void>> deleteExercise(String exerciseId);
}
