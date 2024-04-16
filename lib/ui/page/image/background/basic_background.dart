// author:20254 on 2024/4/16 18:15
// email:junfengling88@gmail.com
// desc:


import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageBasicBackgroundPainter extends CustomPainter {
  final ui.Image image;

  ImageBasicBackgroundPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制白色背景
    final Paint bgPaint = Paint()..color = Colors.white;
    canvas.drawRect(Offset.zero & size, bgPaint);
    // 绘制图片
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}