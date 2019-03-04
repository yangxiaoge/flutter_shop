import 'package:flutter/material.dart';
import './pages/index_page.dart';
import './constants/import.dart';
import 'package:flutter/services.dart';

void main() {
  /// 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
