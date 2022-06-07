import 'package:go_router/go_router.dart';
import 'package:workout_watcher/Views/DashboardView.dart';
import 'package:workout_watcher/Views/SettingsView.dart';
import 'package:workout_watcher/core/login/bloc/bloc.dart';
import 'package:workout_watcher/core/login/presentation/pages/login_page.dart';

GoRouter initGoRouter(AuthBloc authBloc) {
  return GoRouter(
      initialLocation: "/dashboard",
      debugLogDiagnostics: true,
      urlPathStrategy: UrlPathStrategy.path,
      routes: [
        GoRoute(
            path: "/",
            pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey, child: const LoginPage())),
        GoRoute(
            path: "/dashboard",
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: DashboardView())),
        GoRoute(
            path: "/settings",
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const SettingsView())),
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
