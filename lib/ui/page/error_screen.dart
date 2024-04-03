// author:20254 on 2024/3/29 14:14
// email:junfengling88@gmail.com
// desc:

import 'package:flutter_application_demo/routes/router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class RouterErrorScreen extends StatelessWidget {
  const RouterErrorScreen({required this.routerState, super.key});

  /// The label
  final GoRouterState routerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('${routerState.uri} does not exist'),
          ElevatedButton(
              onPressed: () => router.go('/a'),
              child: const Text('Go to home')),
        ],
      )),
    );
  }
}
