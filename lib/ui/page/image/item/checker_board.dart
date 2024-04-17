// author:20254 on 2024/4/17 17:17
// email:junfengling88@gmail.com
// desc:

import 'package:flutter/material.dart';

class Checkerboard extends StatelessWidget {
  final double width;
  final double height;

  const Checkerboard({required this.width, required this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CheckerboardPaint(width: width, height: height),
      size: Size(width, height), // 使用传入的宽高
    );
  }
}

class CheckerboardPaint extends CustomPainter {
  final double width;
  final double height;

  CheckerboardPaint({required this.width, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    const double tileSize = 6.0; // 方格的大小

    for (double x = 0.0; x < size.width; x += tileSize) {
      for (double y = 0.0; y < size.height; y += tileSize) {
        final Color color =
        (x / tileSize + y / tileSize) % 2 == 0 ? const Color.fromARGB(0xFF, 0xE9, 0xE9, 0xE9) : Colors.white;
        paint.color = color;
        canvas.drawRect(Rect.fromLTWH(x, y, tileSize, tileSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is CheckerboardPaint) {
      return oldDelegate.width != width || oldDelegate.height != height;
    }
    return true;
  }
}
