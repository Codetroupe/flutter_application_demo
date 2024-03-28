import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/route_navigation.dart';
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
  ],
  errorBuilder: (_, GoRouterState state) => Scaffold(
    appBar: AppBar(title: const Text('Page not found')),
    body: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('${state.uri} does not exist'),
        ElevatedButton(
            onPressed: () => router.go('/a'), child: const Text('Go to home')),
      ],
    )),
  ),
  // 配置全局转场动画

);
