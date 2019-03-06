import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service/service_url.dart';

/// 获取首页主体内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据.......');
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    var formData = {'lon': '32.162746', 'lat': '118.703763'};
    response = await dio.post(servicePath[homePageContent], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('ERROR: ============$e');
  }
}
