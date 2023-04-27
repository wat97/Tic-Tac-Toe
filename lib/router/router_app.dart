import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/dashboard/dashboard_page.dart';
import '../features/dashboard/dashboard_provider.dart';
import '../features/features.dart';

import '../features/login/login.dart';
import '../features/plan_general/plan_general.dart';
import 'router_enum.dart';
import 'transition/transition_fade.dart';

class RouterApp {
  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: RouterNavigation.routesplash,
    routes: [
      GoRoute(
        name: RouterNavigation.routesplash,
        path: RouterNavigation.routesplash,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => SplashProvider(),
          builder: (context, child) => const SplashPage(),
        ),
      ),
      GoRoute(
        name: RouterNavigation.routelogin,
        path: RouterNavigation.routelogin,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => LoginProvider(state.extra as String),
          builder: (context, child) => const LoginPage(),
        ),
        pageBuilder: (context, state) {
          return TransitionFadeRoute<void>(
            key: state.pageKey,
            child: ChangeNotifierProvider(
              create: (context) => LoginProvider(state.extra as String),
              builder: (context, child) => const LoginPage(),
            ),
            transitionDuration: const Duration(milliseconds: 10),
          );
        },
      ),
      GoRoute(
        name: RouterNavigation.routedashboard,
        path: RouterNavigation.routedashboard,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
          builder: (context, child) => const DashboardPage(),
        ),
        pageBuilder: (context, state) {
          return TransitionFadeRoute<void>(
            key: state.pageKey,
            child: ChangeNotifierProvider(
              create: (context) => DashboardProvider(),
              builder: (context, child) => const DashboardPage(),
            ),
            transitionDuration: const Duration(milliseconds: 10),
          );
        },
      ),
      GoRoute(
        name: RouterNavigation.routeplangeneral,
        path: RouterNavigation.routeplangeneral,
        builder: (context, state) => ChangeNotifierProvider(
          create: (context) => PlanGeneralProvider(),
          builder: (context, child) => const PlanGeneral(),
        ),
        pageBuilder: (context, state) {
          return TransitionFadeRoute<void>(
            key: state.pageKey,
            child: ChangeNotifierProvider(
              create: (context) => PlanGeneralProvider(),
              builder: (context, child) => const PlanGeneral(),
            ),
            transitionDuration: const Duration(milliseconds: 10),
          );
        },
      ),
    ],
  );
}
