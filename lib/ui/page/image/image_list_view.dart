// author:20254 on 2024/4/16 17:13
// email:junfengling88@gmail.com
// desc:
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/image/item/image_basic_item_view.dart';
import 'package:flutter_application_demo/utils/log_util.dart';

import 'image_enum.dart';

class ImageListView extends StatefulWidget {
  const ImageListView({
    super.key,
    this.text,
    required this.listType,
    required this.rslPath,
  });

  final String? text;
  final TemplateListType? listType;
  final String? rslPath;

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  List<dynamic> images = []; // 保存 ImageWithBackground 组件的列表

  @override
  void initState() {
    super.initState();
    _loadListData();
  }

  Future<void> _loadListData() async {
    LogI(widget.rslPath);
    if (widget.rslPath != null) {
      switch (widget.listType) {
        case TemplateListType.basic:
          //基础模板
          setState(() {
            List<BasicColor> basicColor = BasicColor.values;
            //遍历枚举
            for (var item in basicColor) {
              images.add(ImageBasicItemView(
                  tempType: TemplateListType.basic,
                  tempParam: item,
                  rslPath: widget.rslPath));
            }
          });
          break;
        default:
          print('Unknown color');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2, // 设置一个有限高度
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: images[index],
          );
        },
      ),
    );
  }
}
