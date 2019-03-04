import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/import.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        appBar: AppBar(
          title: Text(Constants.appName),
        ),
        body: tabPages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: _bottomItems,
          onTap: (index) {
            print('点击了 index $index');
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
