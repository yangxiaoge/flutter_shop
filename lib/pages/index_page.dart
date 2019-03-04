import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/import.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _bottomItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bottomItems = [
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('首页')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search), title: Text('分类')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.appName),
        ),
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
