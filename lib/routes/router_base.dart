// author:20254 on 2024/3/28 18:26
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///fade界面转场
///用例:
///fadeTransitionPage(
///       'details/:param',
///      (BuildContext context, GoRouterState state) => DetailsScreen(
///             label: 'B',
///             param: state.pathParameters['param'],
///           )),
fadeTransitionPageRoute(
    path, Widget Function(BuildContext, GoRouterState) child) {
  return GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomTransitionPage<void>(
        key: state.pageKey,
        child: child(context, state),
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}

fadeTransitionPageRouteWithParams(
    path, Widget Function(BuildContext, GoRouterState) child,params) {
  return GoRoute(
    path: path,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomTransitionPage<void>(
        key: state.pageKey,
        child: child(context, state),
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
      );
    },
  );
}




fadeTransitionPage(BuildContext context, GoRouterState state, child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
// Change the opacity of the screen using a Curve based on the the animation's
// value
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
