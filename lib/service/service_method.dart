import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service/service_url.dart';

///统一请求封装
Future request(String urlKey, {formData}) async {
  try {
    print('开始获取${getServiceName(urlKey)}数据.......');

    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[urlKey]);
    } else {
      response = await dio.post(servicePath[urlKey], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('获取数据异常，ERROR: ============$e');
  }
}

/// 获取首页主体内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据.......');
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'lon': '32.162746', 'lat': '118.703763'};
    response = await dio.post(servicePath[homePageContent], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('getHomePageContent，ERROR: ============$e');
  }
}

/// 获取首页火爆商品
Future getHomePageBelowConten() async {
  try {
    print('商店首页火爆商品.......');
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    int page = 1;
    response = await dio.post(servicePath[homePageBelowConten], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('getHomePageBelowConten，ERROR: ============$e');
  }
}

///获取分类
Future getCategory() async {
  try {
    print('商店首页火爆商品.......');
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'lon': '32.162746', 'lat': '118.703763'};
    response = await dio.post(servicePath[category], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('getCategory，ERROR: ============$e');
  }
}
