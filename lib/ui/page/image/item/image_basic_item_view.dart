// author:20254 on 2024/4/16 17:12
// email:junfengling88@gmail.com
// desc:
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/image/image_enum.dart';
import 'package:flutter_application_demo/ui/page/image/item/checker_board.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

class ImageBasicItemView extends StatefulWidget {
  const ImageBasicItemView({
    super.key,
    this.text,
    required this.tempType,
    required this.tempParam,
    required this.rslPath,
  });

  final String? text;
  final String? rslPath;
  final TemplateListType? tempType;
  final BasicColor? tempParam;

  @override
  State<ImageBasicItemView> createState() => _ImageBasicItemViewState();
}

class _ImageBasicItemViewState extends State<ImageBasicItemView> {
  late Image _image;
  Uint8List? _imageBytes;
  File? _savedFile;
  var _screenWith;

  Future<void> _loadAndModifyImage() async {
    if (widget.rslPath != null) {
      final file = File(widget.rslPath!);
      final imageBytes = await file.readAsBytes();

      ui.decodeImageFromList(imageBytes, (image) async {
        if (image != null) {
          // 创建用于绘制的PictureRecorder和Canvas
          final recorder = ui.PictureRecorder();
          final canvas = Canvas(recorder);
          var color;
          switch (widget.tempParam) {
            case BasicColor.transparent:
              color = Colors.transparent;
            case BasicColor.white:
              color = Colors.white;
            case BasicColor.black:
              color = Colors.black;
            case BasicColor.grey:
              color = Colors.grey;
            default:
              color = Colors.transparent;
          }
          final paint = Paint()..color = color;
          // 在Canvas上绘制一个矩形以覆盖整个图像
          canvas.drawRect(
              Rect.fromLTWH(
                  0, 0, image.width.toDouble(), image.height.toDouble()),
              paint);

          // 在Canvas上绘制原始图像
          canvas.drawImage(image, Offset.zero, paint);

          // 结束录制并创建Picture
          final picture = recorder.endRecording();

          // 将Picture转换为Image
          final img = await picture.toImage(image.width, image.height);

          // 将Image转换为PNG格式的字节数据
          final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

          // 更新状态以显示修改后的图像
          setState(() {
            _screenWith = MediaQuery.of(context).size.width / 4;
            _imageBytes = byteData?.buffer.asUint8List();
          });
        }
      });
    }
  }

  Future<void> _saveImageToLocal() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final filePath = '$directory/modified_image.png';
    final file = File(filePath);
    await file.writeAsBytes(_imageBytes!);
    setState(() {
      _savedFile = file;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.tempParam == BasicColor.transparent) {
      _loadImage();
    } else {
      _loadAndModifyImage();
    }
  }

  Future<void> _loadImage() async {
    if (widget.rslPath != null) {
      _image = Image.file(File(widget.rslPath!));
      setState(() {
        _screenWith = MediaQuery.of(context).size.width / 4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: Container(
          padding: const EdgeInsets.all(0), // 设置边框内边距
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // 边框颜色和宽度
            borderRadius: BorderRadius.circular(2), // 边框圆角
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0), // 图像圆角略小于边框圆角
            child: BasicColor.transparent == widget.tempParam
                ? _image == null
                    ? const CircularProgressIndicator()
                    : Stack(children: [
                        Checkerboard(width: 100,height: 200), // 在底层绘制方格
                        _image,
                      ])
                : _imageBytes == null
                    ? const CircularProgressIndicator()
                    : Image.memory(_imageBytes!),
          ),
        ),
      ),
    );
  }
}
