import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/router_page.dart';
import 'package:flutter_application_demo/ui/page/root_screen.dart';
import 'package:flutter_application_demo/ui/page/root_screen_b.dart';
import 'package:go_router/go_router.dart';

/// author:20254 on 2024/3/28 16:28
/// email:junfengling88@gmail.com
/// desc:导航路由

final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

///导航图标,标题设置
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

///导航路由集合
final List<RouteBase> routerNavigation = [
  StatefulShellRoute.indexedStack(
    builder: (BuildContext context, GoRouterState state,
        StatefulNavigationShell navigationShell) {
      // Return the widget that implements the custom shell (in this case
      // using a BottomNavigationBar). The StatefulNavigationShell is passed
      // to be able access the state of the shell and to navigate to other
      // branches in a stateful way.
      return ScaffoldWithNavBar(navigationShell: navigationShell);
    },
    branches: <StatefulShellBranch>[
      // The route branch for the first tab of the bottom navigation bar.
      StatefulShellBranch(
        navigatorKey: _sectionANavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            path: '/a',
            builder: (BuildContext context, GoRouterState state) =>
                const RootScreen(
              label: 'A',
              detailsPath: '/a/face_detector',
              secondDetailsPath: '/a/segmenter',
            ),
            routes: <RouteBase>[
              // The details screen to display stacked on navigator of the
              // first tab. This will cover screen A but not the application
              // shell (bottom navigation bar).
              ...routerTabOfHome
            ],
          ),
        ],
      ),
      // The route branch for the second tab of the bottom navigation bar.
      StatefulShellBranch(
        // It's not necessary to provide a navigatorKey if it isn't also
        // needed elsewhere. If not provided, a default key will be used.
        routes: <RouteBase>[
          GoRoute(
            // The screen to display as the root in the second tab of the
            // bottom navigation bar.
            path: '/b',
            builder: (BuildContext context, GoRouterState state) =>
                const RootScreenB(
              label: 'B',
              detailsPath: '/b/details/1',
              secondDetailsPath: '/d',
            ),
            routes: <RouteBase>[...routerTabOfProject],
          ),
        ],
      ),
    ],
  ),
];
