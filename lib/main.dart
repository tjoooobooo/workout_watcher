import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/di/injection_container.dart' as di;
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/presentation/pages/login_page.dart';
import 'package:workout_watcher/core/util/bloc_observer.dart';
import 'package:workout_watcher/features/charts/bloc/charts_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_bloc.dart';
import 'package:workout_watcher/features/measurements/bloc/measurements_event.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/creation/plan_create_event.dart';
import 'package:workout_watcher/features/plans/bloc/plan_bloc.dart';
import 'package:workout_watcher/features/plans/bloc/plan_event.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

import 'Views/DashboardView.dart';
import 'firebase_options.dart';
import 'utils/AuthenticationService.dart';

Future<void> main() async {
  Loggy.initLoggy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
      () => {
            runApp(MultiBlocProvider(providers: [
              BlocProvider<AuthBloc>(create: (context) {
                return sl<AuthBloc>()..add(AppStartedEvent());
              }),
              BlocProvider<ExercisesBloc>(create: (context) {
                return sl<ExercisesBloc>()
                  ..add(GetAllExercisesEvent(refreshCache: true));
              }),
              BlocProvider<MeasurementsBloc>(create: (context) {
                return sl<MeasurementsBloc>()
                  ..add(GetAllMeasurementsEvent(refreshCache: true));
              }),
              BlocProvider<PlanBloc>(create: (context) {
                return sl<PlanBloc>()
                  ..add(GetAllPlansEvent(refreshCache: true));
              }),
              BlocProvider<PlanCreateBloc>(create: (context) {
                return sl<PlanCreateBloc>()
                  ..add(InitialEvent());
              }),
              BlocProvider<ChartsBloc>(create: (context) {
                return sl<ChartsBloc>();
              })
            ], child: const TrackMyWorkoutApp()))
          },
      blocObserver: kReleaseMode ? null : SimpleBlocObserver(),
      storage: storage);
}

class TrackMyWorkoutApp extends StatelessWidget {
  const TrackMyWorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goRouter = sl<GoRouter>();

    return MaterialApp.router(
      // General
      title: "Workout-Watcher",
      debugShowCheckedModeBanner: false,
      // Routing
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      // Theme
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff000e75),
        ),
        primarySwatch: Colors.blueGrey,
        dividerColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white
          )
        ).apply(
          bodyColor: Colors.white
        ),
        primaryColor: const Color(0xff000452),
        primaryColorLight: Colors.lightBlueAccent,
        primaryColorDark: const Color(0xff000000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();
//
//     if (firebaseUser != null) {
//       return DashboardView();
//     }
//
//     return const LoginPage();
//   }
// }
