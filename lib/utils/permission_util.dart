// author:20254 on 2024/4/7 14:36
// email:junfengling88@gmail.com
// desc:

// 请求读取和删除内存权限
import 'package:flutter_application_demo/utils/log_util.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  if (await Permission.storage.isGranted) {
    // 权限已经授予
    // 执行你的读写操作
  } else {
    // 请求权限
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    // 检查权限请求的结果
    if (statuses[Permission.storage] == PermissionStatus.granted) {
      // 权限已授予
      // 执行你的读写操作
    } else {
      // 权限被拒绝
      // 处理权限被拒绝的情况
    }
  }
}