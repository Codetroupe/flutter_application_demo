import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/painters/coordinates_translator.dart';
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:google_mlkit_subject_segmentation/google_mlkit_subject_segmentation.dart';

class SubjectSegmentationPainter extends CustomPainter {
  SubjectSegmentationPainter(
    this.mask,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final SegmentationMask mask;
  final Size imageSize;
  final Color color = Colors.red;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final width = mask.width;
    final height = mask.height;
    final confidences = mask.confidences;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int tx = translateX(
          x.toDouble(),
          size,
          Size(mask.width.toDouble(), mask.height.toDouble()),
          rotation,
          cameraLensDirection,
        ).round();
        final int ty = translateY(
          y.toDouble(),
          size,
          Size(mask.width.toDouble(), mask.height.toDouble()),
          rotation,
          cameraLensDirection,
        ).round();

        // LogI("像素点数据:");
        // LogI(confidences[(y * width) + x]);
        // LogI(confidences[(y * width) + x] /10  );
        if( confidences[(y * width) + x]<1){
          final double opacity = confidences[(y * width) + x] * 0.5;
          paint.color = color.withOpacity(0.2);
          canvas.drawCircle(Offset(tx.toDouble(), ty.toDouble()), 2, paint);
        }

      }
    }
  }

  @override
  bool shouldRepaint(SubjectSegmentationPainter oldDelegate) {
    return oldDelegate.mask != mask;
  }
}
