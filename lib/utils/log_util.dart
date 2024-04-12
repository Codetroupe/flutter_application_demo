// author:20254 on 2024/4/7 14:06
// email:junfengling88@gmail.com
// desc:

import 'package:logger/logger.dart';

const String _tag = "flutter-demo";

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

LogV(String msg) {
  _logger.v("$_tag :: $msg");
}

LogD(String msg) {
  _logger.d("$_tag :: $msg");
}

LogI(dynamic msg) {
  _logger.i("$_tag :: $msg");
}

LogW(String msg) {
  _logger.w("$_tag :: $msg");
}

LogE(String msg) {
  _logger.e("$_tag :: $msg");
}

LogWTF(String msg) {
  _logger.wtf("$_tag :: $msg");
}