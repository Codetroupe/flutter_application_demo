// author:20254 on 2024/4/16 17:13
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/image/image_enum.dart';
import 'package:flutter_application_demo/ui/page/image/image_list_view.dart';
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:go_router/go_router.dart';

class ImagePageView extends StatefulWidget {
  const ImagePageView({
    super.key,
    required this.title,
    required this.rslPath,
  });

  final String title;
  final String? rslPath;

  @override
  State<ImagePageView> createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  @override
  void initState() {
    super.initState();
    LogI('执行了1');
    LogI(widget.rslPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _galleryBody(widget));
  }

  Widget _galleryBody(widget) {
    return ListView(shrinkWrap: true, children: [
      Text("Basic"),
      ImageListView(listType: TemplateListType.basic, rslPath: widget.rslPath),
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 16),
      //   child: ElevatedButton(
      //     onPressed: _getBitmapImage,
      //     child: Text('From Assets'),
      //   ),
      // ),
    ]);
  }
}
