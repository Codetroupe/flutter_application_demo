// author:20254 on 2024/3/28 16:44
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/utils/permission_util.dart';
import 'package:go_router/go_router.dart';

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  /// The path to another detail page
  final String? secondDetailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root of section $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                requestStoragePermission();
              },
              child: const Text('handlePermissions'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath);
              },
              child: const Text('Face Mach'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(secondDetailsPath!);
              },
              child: const Text('Subject Segmentation'),
            ),
            // const Padding(padding: EdgeInsets.all(4)),
            // TextButton(
            //   onPressed: () {
            //     GoRouter.of(context).go('/a/selfie_segmentation');
            //   },
            //   child: const Text('Selfie Segmentation'),
            // ),
          ],
        ),
      ),
    );
  }
}
