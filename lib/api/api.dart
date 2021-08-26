import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ims/model/news.dart';

import 'package:ims/model/menu.dart';

import '../constant.dart';

const host = "172.27.12.180";
var options = BaseOptions(
  baseUrl: 'http://$host:8080/v1/api',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
int f = 0;
Dio dio = Dio(options)
  ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    // Do something before request is sent
    return handler.next(options); //continue
    // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
    // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    //
    // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
    // 这样请求将被中止并触发异常，上层catchError会被调用。
  }, onResponse: (response, handler) {
    print(response.data.toString());
    if (response.data["code"] >= 40000) {
      print(response.data["err"]);
      handler.resolve(response.data);
    }
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
    return handler.resolve(response);
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

class Api {
  static Future<List<Menu>> getMenu() async {
    try {
      Response ret = await dio.get("/menus");
      List<dynamic> data = ret.data["data"];
      return data.map((e) => Menu.fromJson(e)).toList();
    } catch (e) {
      print("异常:" + e.toString());
    }
    return [];
  }

  static Future<List<News>> getNews() async {
    try {
      Response ret = await dio163.post("/getWangYiNews");
      List<dynamic> data = ret.data["result"];
      return data.map((e) => News.fromJson(e)).toList();
    } catch (e) {
      print("异常:" + e.toString());
    }
    return [];
  }

  // Future<T> request(Function fn) async {
  //   Response resp = await fn();
  //   if (resp.statusCode == HttpStatus.ok) {}
  // }
  static Future<int> getFollow() async {
    await Future.delayed(Duration(seconds: 1));
    if (f == 0) {
      f = 1;
    } else {
      f = 0;
    }
    return Future.value(f);
  }
}
