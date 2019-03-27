import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: TabBar(
              labelColor: Color(0xFF333333),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Color(0xFF888888),
              indicatorColor: Color(0xFF51DEC6),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              tabs: <Widget>[
                Tab(text: '精选'),
                Tab(text: '女生'),
                Tab(text: '男生'),
                Tab(text: '漫画'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //如果需要支持阿拉伯（RTL）从右往左展示：
            //1, 通过国际化：请看： https://stackoverflow.com/questions/50535185/right-to-left-rtl-in-flutter
            //2，以下是通过Directionality直接去选择TextDirection
            Center(child: Text('购物车页面')),
            Directionality(
                textDirection: TextDirection.rtl, child: Text('购物车页面')),
            Directionality(
                textDirection: TextDirection.ltr, child: Text('购物车页面')),
            Container(
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
