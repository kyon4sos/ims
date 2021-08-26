import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ims/api/api.dart';

Dio dio163 = new Dio(BaseOptions(
  baseUrl: "https://api.apiopen.top",
  connectTimeout: 5000,
  receiveTimeout: 3000,
))
  ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }, onResponse: (response, handler) {
    print("响应拦截器");
    print(response.data["result"]);
    return response.data;
    // if (response.data["code"] == CODE_OK) {}
    return handler.next(response); // continue
    // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }, onError: (DioError e, handler) {
    // Do something with response error
    return handler.next(e); //continue
    // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
  }));

class Request {
  static req(method) {}

  static get<T>(String path) async {
    Response ret = await dio.get(path);
    var decode = jsonDecode(ret.data["result"]);
  }
}
