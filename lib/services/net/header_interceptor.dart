// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';

// class HeaderInterceptor extends Interceptor {
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     Map<String, dynamic> headers = options.headers;
//     headers['clientId'] = 1; //渠道(1.APP 2.Web）
//     if (Platform.isAndroid) {
//       headers['systemName'] = 'Android'; //系统名称
//     } else if (Platform.isIOS) {
//       headers['systemName'] = 'iOS'; //系统名称
//     }

//     var time = DateTime.now().millisecondsSinceEpoch;
//     headers['ts'] = time; //时间戳
//     String sign = getParamsStr(options, time);
//     headers['sign'] = sign; //参数加密签名
//     headers['language'] = 'MY'; //语言环境
//     headers['Accept'] = 'application/json';
//     options.headers = headers;
//     handler.next(options);
//   }

//   getParamsStr(RequestOptions options, int time) {
//     StringBuffer stringBuffer = new StringBuffer();
//     String? paramsStr;
//     var method = options.method;
//     if (method == 'GET') {
//       if (options.queryParameters.isNotEmpty) {
//         String query = options.uri.query;
//         var splitArray = query.split('&');
//         var splayTreeMap = new SplayTreeMap();
//         splitArray.forEach((split) {
//           var splitChild = split.split('=');
//           splayTreeMap[splitChild[0]] = Uri.encodeQueryComponent(splitChild[1]);
//         });
//         paramsStr = json.encode(splayTreeMap);
//         if (paramsStr.isNotEmpty) {
//           stringBuffer.write('$paramsStr&');
//         } else {
//           stringBuffer.write('{}&');
//         }
//       } else {
//         stringBuffer.write('{}&');
//       }
//     } else if (method == 'POST') {
//       var data = options.data;
//       if (data is FormData) {
//         if (data.fields.isNotEmpty) {
//           String replace = data.fields
//               .join(",")
//               .replaceAll('MapEntry', '')
//               .replaceAll('(', '')
//               .replaceAll(')', '');
//           paramsStr = replace;
//           if (paramsStr.isNotEmpty) {
//             stringBuffer.write('{$paramsStr}&');
//           } else {
//             stringBuffer.write('{}&');
//           }
//         } else {
//           stringBuffer.write('{}&');
//         }
//       } else {
//         paramsStr = jsonEncode(data);
//         if (paramsStr.isNotEmpty) {
//           stringBuffer.write('$paramsStr&');
//         } else {
//           stringBuffer.write('{}&');
//         }
//       }
//     }
//     // NativeUtils.sendNativeData(NativeUtils.NATIVE_LOG, paramsStr.toString());
//     // print(paramsStr.toString());
//     stringBuffer.write('ts=$time&');
//     // stringBuffer.write('tmpsign=${DioManager.getInstance().signKey}');
//     String toString = stringBuffer.toString().replaceAll("\"", "");
//     // NativeUtils.sendNativeData(NativeUtils.NATIVE_LOG, toString);
//     // print(toString);
//     // Get.log.printInfo(info: '拼接后：$toString');
//     var content = new Utf8Encoder().convert(toString);
//     // var digest = md5.convert(content);
//     String md5Encode = '';//hex.encode(digest.bytes).toUpperCase();
//     // Get.log.printInfo(info: 'MD5：$md5Encode');
//     return md5Encode;
//   }
// }