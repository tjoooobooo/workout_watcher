import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/exercises/data/models/exercise_model.dart';
import 'package:workout_watcher/features/measurements/data/models/measurement_model.dart';

abstract class MeasurementRepository {
  Future<Either<Failure, List<MeasurementModel>>> getAll(bool refreshCache);

  Future<Either<Failure, MeasurementModel>> getById(String id);

  Future<Either<Failure, void>> add(MeasurementModel measurement);

  Future<Either<Failure, void>> update(MeasurementModel measurement);

  Future<Either<Failure, void>> delete(String measurementId);
}
