import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/painters/face_detector_painter.dart';
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'detector_view.dart';

class FaceDetectorView extends StatefulWidget {
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      minFaceSize: 0.8
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
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
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        bool faceLook = face.headEulerAngleY! >= -12 && face.headEulerAngleY! <= 12;
        text += 'face-y-in(-12~12): ${faceLook}\n\n';
        text += 'face-leftEyeOpenProbability: ${face.leftEyeOpenProbability}\n\n';
        text += 'face-rightEyeOpenProbability: ${face.rightEyeOpenProbability}\n\n';
        text += 'face-smilingProbability(<0.7): ${face.smilingProbability}\n\n';
        text += 'face: ${face.boundingBox}\n\n';
        text += 'face-x: ${face.headEulerAngleX}\n\n';
        text += 'face-y: ${face.headEulerAngleY}\n\n';
        text += 'face-z: ${face.headEulerAngleZ}\n\n';
        text += '\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
