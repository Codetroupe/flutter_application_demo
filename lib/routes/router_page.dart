// author:20254 on 2024/3/28 16:51
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/router_base.dart';
import 'package:flutter_application_demo/ui/page/details_screen.dart';
import 'package:flutter_application_demo/ui/page/image_picker.dart';
import 'package:go_router/go_router.dart';

///首页分支页面路由集合
final List<RouteBase> routerTabOfHome = [
  fadeTransitionPageRoute(
      'details',
      (BuildContext context, GoRouterState state) =>
           ImagePickerPage()),
  fadeTransitionPageRoute(
      'c',
          (BuildContext context, GoRouterState state) => DetailsScreen(
        label: 'C',
        param: state.pathParameters['param'],
      )),
];

///工作分支页面路由集合
final List<RouteBase> routerTabOfProject = [
  fadeTransitionPageRoute(
      'details/:param',
      (BuildContext context, GoRouterState state) => DetailsScreen(
            label: 'B',
            param: state.pathParameters['param'],
          )),
];
