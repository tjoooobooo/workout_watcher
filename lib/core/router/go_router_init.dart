import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Views/DashboardView.dart';
import 'package:workout_watcher/Views/SettingsView.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/presentation/pages/login_page.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercise_page.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercises_list_page.dart';
import 'package:workout_watcher/features/measurements/presentation/pages/measurement_list.dart';
import 'package:workout_watcher/features/measurements/presentation/pages/measurement_page.dart';
import 'package:workout_watcher/features/plan/presentation/pages/plan_list_page.dart';

GoRouter initGoRouter(AuthBloc authBloc) {
  return GoRouter(
      initialLocation: "/dashboard",
      debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
            path: "/",
            pageBuilder: (context, state) =>
                NoTransitionPage<void>(
                    key: state.pageKey, child: const LoginPage())),
        GoRoute(
            path: "/dashboard",
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: DashboardView())),
        GoRoute(
            path: "/settings",
            pageBuilder: (context, state) =>
                NoTransitionPage(
                    key: state.pageKey, child: const SettingsView())),
        GoRoute(
            path: "/plan",
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: PlanListPage())),
        GoRoute(
            path: "/exercises",
            pageBuilder: (context, state) =>
                NoTransitionPage(
                    key: state.pageKey, child: const ExercisesListPage())),
        GoRoute(
            path: "/exercise/:exercise_id",
            pageBuilder: (context, state) {
              String exerciseId = (state.params["exercise_id"] ?? 0).toString();

              return NoTransitionPage(key: state.pageKey, child: ExercisePage(
                  exerciseId: exerciseId
              ));
            }),
        GoRoute(
            path: "/measurements",
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const MeasurementList())),
        GoRoute(
            path: "/measurement/:measurement_id",
            pageBuilder: (context, state) {
              String measurmentId = (state.params["measurement_id"] ?? 0).toString();
              return NoTransitionPage(
                  key: state.pageKey, child: MeasurementPage(measurementId: measurmentId));
            })
      ],
      redirect: (state) {
        bool isLoggedIn = authBloc.state.status.isLoggedIn;

        // redirect if user is not logged in
        if (state.subloc != "/" && isLoggedIn == false) {
          return "/";
        } else if (isLoggedIn == true && state.subloc == "/") {
          return "/dashboard";
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authBloc.stream));
}
