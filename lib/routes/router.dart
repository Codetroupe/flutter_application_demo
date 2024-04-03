import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/route_navigation.dart';
import 'package:flutter_application_demo/routes/router_base.dart';
import 'package:flutter_application_demo/ui/page/details_screen.dart';
import 'package:flutter_application_demo/ui/page/error_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// The route configuration.
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/a',
  routes: <RouteBase>[
    ///导航路由
    ...routerNavigation,
    fadeTransitionPageRoute(
        '/d',
            (BuildContext context, GoRouterState state) =>
        const DetailsScreen(label: 'D')),
  ],
  errorPageBuilder: (BuildContext context, GoRouterState state) =>
      fadeTransitionPage(context, state, RouterErrorScreen(routerState: state)),

);
