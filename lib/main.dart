import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter/services.dart';

void main() {
  /// 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var childCategory = ChildCategoryProvide();
  var provides = Providers();
  provides..provide(Provider<ChildCategoryProvide>.value(childCategory));

  runApp(ProviderNode(
    providers: provides,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        //https://stackoverflow.com/questions/50212484/what-is-the-difference-between-primarycolor-and-primaryswatch-in-flutter
        //通常最好定义一个primarySwatch而不是primaryColor。因为一些material组件可能会使用不同的阴影，primaryColor如阴影，边框，......
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
