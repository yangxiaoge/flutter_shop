import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/import.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import '../widget/appbar_gradient.dart';

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
    // 放在第一个页面初始化。设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按 iPhone6 的尺寸设计的 (iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    // print(' 设备宽度:${ScreenUtil.screenWidth}'); //Device width
    // print(' 设备高度:${ScreenUtil.screenHeight}'); //Device height
    // print(' 设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
    // print(' 实际宽度的 dp 与设计稿 px 的比例:${ScreenUtil.getInstance().scaleWidth}');
    // print(' 实际高度的 dp 与设计稿 px 的比例:${ScreenUtil.getInstance().scaleHeight}');
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        appBar: gradientAppBar(),
        body: IndexedStack(
          //IndexedStack防止底部tabs重新加载
          children: tabPages,
          index: _currentIndex,
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

  /// 渐变色AppBar
  Widget gradientAppBar() {
    return GradientAppBar(
      gradientStart: Theme.of(context).primaryColorLight,
      gradientEnd: Theme.of(context).primaryColor,
      //  gradientStart: Color(0xFF49A2FC), //手Q渐变色
      //  gradientEnd: Color(0xFF2171F5),
      title: Text(Constants.appName),
    );
  }
}
