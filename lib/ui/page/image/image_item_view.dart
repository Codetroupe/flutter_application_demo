// author:20254 on 2024/4/16 17:12
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_demo/ui/page/image/background/basic_background.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;

class ImageItemView extends StatefulWidget {
  ImageItemView({
    Key? key,
    this.text,
    required this.tempType,
    required this.tempParam,
    required this.rslPath,
  }) : super(key: key);

  final String? text;
  final String? rslPath;
  final int? tempType;
  final String? tempParam;

  @override
  State<ImageItemView> createState() => _ImageItemViewState();
}

class _ImageItemViewState extends State<ImageItemView> {
  String? _path;
  ImagePicker? _imagePicker;
  late ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (widget.rslPath != null) {
      final ByteData data = await rootBundle.load(widget.rslPath!);
      final Uint8List bytes = data.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      setState(() {
        _image = frameInfo.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image == null
            ? CircularProgressIndicator()
            : CustomPaint(
                painter: ImageBasicBackgroundPainter(_image),
                child: SizedBox(
                  width: _image.width.toDouble(),
                  height: _image.height.toDouble(),
                ),
              ),
      ),
    );
  }
}
