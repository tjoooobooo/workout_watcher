import 'package:get_it/get_it.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/data/repositories/login_repository_firebase.dart';
import 'package:workout_watcher/core/features/login/domain/repositorys/login_repository.dart';
import 'package:workout_watcher/core/router/go_router_init.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/data/repositories/exercise_repository_firebase.dart';
import 'package:workout_watcher/features/exercises/domain/repositorys/exercise_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerLazySingleton<AuthBloc>(
        () => AuthBloc(sl()),
  );

  sl.registerLazySingleton<ExercisesBloc>(
        () => ExercisesBloc(sl()),
  );

  // Use cases


  // user


  // Repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryFirebase());
  sl.registerLazySingleton<ExerciseRepository>(() => ExerciseRepositoryFirebase());

  // Data sources


  // Core

  // External
  sl.registerLazySingleton(() => initGoRouter(sl()));

}