import 'package:get_it/get_it.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/data/repositories/login_repository_firebase.dart';
import 'package:workout_watcher/core/features/login/domain/repositorys/login_repository.dart';
import 'package:workout_watcher/core/router/go_router_init.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/data/repositories/exercise_repository_firebase.dart';
import 'package:workout_watcher/features/exercises/domain/repositorys/exercise_repository.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_bloc.dart';
import 'package:workout_watcher/features/measurements/data/repositories/measurement_repository_firebase.dart';
import 'package:workout_watcher/features/measurements/domain/repositories/measurment_repository.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/data/repositories/plan_repository_firebase.dart';
import 'package:workout_watcher/features/plans/domain/repositories/plan_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(sl()),
  );

  sl.registerLazySingleton<ExercisesBloc>(
    () => ExercisesBloc(sl()),
  );

  sl.registerLazySingleton<MeasurementsBloc>(
    () => MeasurementsBloc(sl()),
  );

  sl.registerLazySingleton<PlanBloc>(
        () => PlanBloc(sl()),
  );

  sl.registerLazySingleton<PlanCreateBloc>(() => PlanCreateBloc());

  sl.registerLazySingleton<ChartsBloc>(() => ChartsBloc());


  // Use cases

  // user

  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryFirebase());
  sl.registerLazySingleton<ExerciseRepository>(
      () => ExerciseRepositoryFirebase());
  sl.registerLazySingleton<MeasurementRepository>(
      () => MeasurementRepositoryFirebase());
  sl.registerLazySingleton<PlanRepository>(() => PlanRepositoryFirebase());

  // Data sources

  // Core

  // External
  sl.registerLazySingleton(() => initGoRouter(sl()));
}
