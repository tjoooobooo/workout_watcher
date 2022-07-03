import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Views/DashboardView.dart';
import 'package:workout_watcher/Views/SettingsView.dart';
import 'package:workout_watcher/core/features/login/bloc/bloc.dart';
import 'package:workout_watcher/core/features/login/presentation/pages/login_page.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercise_page.dart';
import 'package:workout_watcher/features/exercises/presentation/pages/exercises_list_page.dart';
import 'package:workout_watcher/features/measurements/presentation/pages/measurement_list.dart';
import 'package:workout_watcher/features/measurements/presentation/pages/measurement_page.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_page.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_list_page.dart';
import 'package:workout_watcher/features/plans/presentation/pages/plan_page_days.dart';

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
            path: "/plans",
            pageBuilder: (context, state) {
              return NoTransitionPage(key: state.pageKey, child: const PlanListPage());
            }),
        GoRoute(
            path: "/plan/:plan_id",
            pageBuilder: (context, state) {
              String planId = (state.params["plan_id"] ?? 0).toString();

              return NoTransitionPage(key: state.pageKey, child: PlanPage(planId: planId));
            }),
        GoRoute(
            path: "/plan-day/:plan_id",
            pageBuilder: (context, state) {
              String planId = (state.params["plan_id"] ?? 0).toString();

              return NoTransitionPage(key: state.pageKey, child: PlanPageDays(planId: planId));
            }),
        GoRoute(
            path: "/exercises",
            pageBuilder: (context, state) {
              bool selectionMode = state.queryParams["selectionMode"] == "true";

              return NoTransitionPage(
                  key: state.pageKey, child: ExercisesListPage(selectionMode: selectionMode));
            }),
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
                NoTransitionPage(
                    key: state.pageKey, child: const MeasurementList())),
        GoRoute(
            path: "/measurement/:measurement_id",
            pageBuilder: (context, state) {
              String measurmentId = (state.params["measurement_id"] ?? 0)
                  .toString();
              return NoTransitionPage(
                  key: state.pageKey,
                  child: MeasurementPage(measurementId: measurmentId));
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
