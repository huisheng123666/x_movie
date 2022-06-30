import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double mediaWidth = 0;

class ResponseErr {
  final String msg;

  ResponseErr(this.msg);
}

class Util {
  static Dio dio = Dio();

  static calc(int px, BuildContext context) {
    if (mediaWidth == 0) {
      mediaWidth = MediaQuery.of(context).size.width;
    }
    return px / 375 * mediaWidth;
  }

  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static setStatusBarTextColor(SystemUiOverlayStyle theme) {
    SystemChrome.setSystemUIOverlayStyle(theme);
  }

  static bottomSafeHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static initDio() {
    Util.dio.options = BaseOptions(
      baseUrl: 'http://192.168.28.17:4000/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Util.dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onResponse: (response, handler) {
        // print(response);
        if (response.data['code'] == 200) {
          return handler.next(Response(
              requestOptions: response.requestOptions, data: response.data));
        } else {
          return handler.resolve(response);
        }
      },
      onError: (e, handler) {
        return handler.resolve(Response(
            requestOptions: e.requestOptions,
            data: <String, String>{'msg': '网络错误，请稍后再试'}));
      },
    ));
  }
}
