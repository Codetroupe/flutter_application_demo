// author:20254 on 2024/3/28 16:51
// email:junfengling88@gmail.com
// desc:


import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/router_base.dart';
import 'package:flutter_application_demo/ui/page/details_screen.dart';
import 'package:go_router/go_router.dart';

///首页分支页面路由集合
final List<RouteBase> routerTabOfHome = [
  GoRoute(
    path: 'details',
    builder: (BuildContext context, GoRouterState state) =>
    const DetailsScreen(label: 'A'),
  ),
];


///工作分支页面路由集合
final List<RouteBase> routerTabOfProject = [
  fadeTransitionPage('details/:param',DetailsScreen(
    label: 'B',
    // param: state.pathParameters['param'],
  )),

];
