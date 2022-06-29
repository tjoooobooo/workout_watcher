import 'package:dartz/dartz.dart';
import 'package:workout_watcher/core/error/failures.dart';
import 'package:workout_watcher/features/plans/data/models/plan_model.dart';

abstract class PlanRepository {
  Future<Either<Failure, List<PlanModel>>> getAll(bool refreshCache);

  Future<Either<Failure, PlanModel>> getById(String id);

  Future<Either<Failure, PlanModel>> add(PlanModel plan);

  Future<Either<Failure, PlanModel>> update(PlanModel plan);

  Future<Either<Failure, void>> delete(String id);
}
