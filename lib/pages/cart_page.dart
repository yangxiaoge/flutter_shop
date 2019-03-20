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
               labelColor:Color(0xFF333333),
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
            Center(child: Text('购物车页面')),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
