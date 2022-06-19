import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:workout_watcher/core/di/injection_container.dart';
import 'package:workout_watcher/core/di/injection_container.dart' as di;
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/presentation/pages/login_page.dart';
import 'package:workout_watcher/core/util/bloc_observer.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_bloc.dart';
import 'package:workout_watcher/features/exercises/bloc/exercises_event.dart';
import 'package:workout_watcher/utils/FirebaseHandler.dart';

import 'Views/DashboardView.dart';
import 'utils/AuthenticationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => {
        runApp(MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(create: (context) {
            return sl<AuthBloc>()..add(AppStartedEvent());
          }),
          BlocProvider<ExercisesBloc>(create: (context) {
            return sl<ExercisesBloc>()..add(GetAllExercisesEvent());
          })
        ], child: const TrackMyWorkoutApp()))
      }, blocObserver: kReleaseMode ? null : SimpleBlocObserver(), storage: storage);

  await FirebaseHandler.getAllExercises();
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
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      // Theme
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff000e75),
        ),
        primarySwatch: Colors.blueGrey,
        primaryColorLight: Colors.lightBlueAccent,
        dividerColor: Colors.black,
        primaryColor: const Color(0xff000e75),
        primaryColorDark: const Color(0xff000428),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return DashboardView();
    }

    return LoginPage();
  }
}
