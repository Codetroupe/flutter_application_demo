
// author:20254 on 2024/4/16 17:13
// email:junfengling88@gmail.com
// desc:
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/ui/page/image/image_item_view.dart';

class ImageListView extends StatefulWidget {
  @override
  _ImageListViewState createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  List<ImageItemView> images = []; // 保存 ImageWithBackground 组件的列表

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal Image List'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length, // 根据列表长度动态生成组件
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: images[index], // 根据索引获取对应的 ImageWithBackground 组件
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 在点击 FloatingActionButton 时添加一个新的 ImageWithBackground 组件到列表中
          setState(() {
            // images.add(ImageItemView());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
