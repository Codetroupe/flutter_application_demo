
// author:20254 on 2024/4/16 17:13
// email:junfengling88@gmail.com
// desc:

// author:20254 on 2024/4/16 17:12
// email:junfengling88@gmail.com
// desc:
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';


class ImageListView extends StatefulWidget {
  ImageListView(
      {Key? key,
        required this.title,
        this.text,
        this.rslPath,
        required this.onImage,
        required this.onDetectorViewModeChanged,
        this.customPaint})
      : super(key: key);
  final CustomPaint? customPaint;
  final String title;
  final String? text;
  final String? rslPath;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
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
      _image != null
          ? SizedBox(
        height: 400,
        width: 400,
        child: Stack(
          alignment: Alignment.center, // 子部件的对齐方式，默认是居中对齐
          fit: StackFit.loose,
          children: <Widget>[
            Image.file(_image!),
            if (widget.customPaint != null) widget.customPaint!
          ],
        ),
      )
          : Icon(
        Icons.image,
        size: 200,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: _getBitmapImage,
          child: Text('From Assets'),
        ),
      ),
    ]);
  }


  Future _getBitmapImage() async {
    if (_image == null) {
      return;
    }
    LogI("bitmapImage数据:::::");
  }



}
