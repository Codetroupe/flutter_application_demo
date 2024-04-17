// author:20254 on 2024/3/28 16:51
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/router_base.dart';
import 'package:flutter_application_demo/ui/page/details_screen.dart';
import 'package:flutter_application_demo/ui/page/face/face_detector_view.dart';
import 'package:flutter_application_demo/ui/page/image/image_page_view.dart';
import 'package:flutter_application_demo/ui/page/image_picker.dart';
import 'package:flutter_application_demo/ui/page/segmenter/selfie_segmenter_view.dart';
import 'package:flutter_application_demo/ui/page/subject/subject_segmenter_view.dart';
import 'package:go_router/go_router.dart';

///首页分支页面路由集合
final List<RouteBase> routerTabOfHome = [
  fadeTransitionPageRoute(
      'selfie_segmentation',
      (BuildContext context, GoRouterState state) =>
           SelfieSegmenterView()),
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
  fadeTransitionPageRoute(
      'segmenter',
          (BuildContext context, GoRouterState state) =>  SubjectSegmenterView()),
  fadeTransitionPageRoute(
      'image_list/:filePath',
          (BuildContext context, GoRouterState state) =>  ImagePageView(title: 'Image Preview', rslPath: state.pathParameters['filePath'])),
  fadeTransitionPageRoute(
      'face_detector',
          (BuildContext context, GoRouterState state) =>  FaceDetectorView()),
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
