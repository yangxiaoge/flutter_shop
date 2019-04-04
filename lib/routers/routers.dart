import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routers {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRouters(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR===>ROUTER WAS NOT FOUND!!!');
      }
    );

    router.define(detailsPage,handler: detailsHandler);
  }
}
