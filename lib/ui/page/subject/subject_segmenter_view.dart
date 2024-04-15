import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/painters/subject_segmentation_painter.dart';
import 'package:flutter_application_demo/ui/page/subject/detector_view.dart';
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';

class SubjectSegmenterView extends StatefulWidget {
  @override
  State<SubjectSegmenterView> createState() => _SubjectSegmenterViewState();
}

class _SubjectSegmenterViewState extends State<SubjectSegmenterView> {
  final SubjectSegmenter _segmenter = SubjectSegmenter(
    mode: SegmenterMode.stream,
    enableRawSizeMask: true,
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() async {
    _canProcess = false;
    _segmenter.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Subject Segmenter',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    LogI("inputImage.toJson()=>${inputImage.toJson()}");

    if (inputImage.filePath != null) {
      Image image = Image.file(File.fromUri(Uri.parse(inputImage.filePath!)));
      // 预先获取图片信息
      image.image
          .resolve(new ImageConfiguration())
          .addListener(new ImageStreamListener((ImageInfo info, bool _) {
        LogI("Image.width=>${info.image.width}");
        LogI("Image.height=>${info.image.height}");
      }));
    }

    final mask = await _segmenter.processImage(inputImage);
    // if (mask != null) {
    //   final maskBck = mask.confidences;
    //   final maskWidth = mask.width;
    //   final maskHeight = mask.height;
    //   LogI("mask数据");
    //   LogI(maskBck);
    //   LogI(maskBck.length);
    //   LogI(maskWidth);
    //   LogI(maskHeight);
    // }

    LogI(inputImage);

    LogI(inputImage.metadata?.size != null);
    LogI(inputImage.metadata?.size.toString());
    LogI(inputImage.metadata?.rotation != null);
    LogI(mask != null);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null &&
        mask != null) {
      LogI("有结果返回:");
      LogI(mask);
      // TODO: Fix SegmentationPainter to rescale on top of camera feed.
      // final painter = SegmentationPainter(
      //   mask,
      //   inputImage.metadata!.size,
      //   inputImage.metadata!.rotation,
      //   _cameraLensDirection,
      // );
      // _customPaint = CustomPaint(painter: painter);
      _customPaint = null;
    } else {
      // TODO: set _customPaint to draw on top of image

      _text =
          'There is a mask with ${(mask?.confidences ?? []).where((element) => element > 0.8).length} elements';
      _customPaint = null;

      if (mask != null) {
        final maskBck = mask.confidences;
        final maskWidth = mask.width;
        final maskHeight = mask.height;
        LogI("mask数据");
        LogI(maskBck);
        LogI(maskBck.length);
        LogI(maskWidth);
        LogI(maskHeight);




        // final painter = SubjectSegmentationPainter(
        //     mask!,
        //     Size(maskWidth.toDouble(),maskHeight.toDouble()), //inputImage.metadata!.size,
        //     InputImageRotation.rotation0deg, //inputImage.metadata!.rotation,
        //     CameraLensDirection.back);
        // _customPaint = CustomPaint(
        //   painter: painter,
        //   size: Size(maskWidth.toDouble(),maskHeight.toDouble()),
        // );
      }


    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
