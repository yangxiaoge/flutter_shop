import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/pages/details_page/details_bottom_buy.dart';
import 'package:flutter_shop/pages/details_page/details_top_area.dart';
import 'package:flutter_shop/pages/details_page/details_explain.dart';
import 'package:flutter_shop/pages/details_page/details_tabbar.dart';
import 'package:flutter_shop/pages/details_page/details_web.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF49A2FC),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('商品详情页'),
        ),
        body: FutureBuilder(
          future: _getGoodsInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailsExplain(),
                        DetailsTabBar(),
                        DetailsWeb(),
                      ],
                    ),
                  ),
                  Provide<CartProvide>(
                    builder: (context, _, val) {
                      return Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: DetailsBottom(),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          },
        ));
  }

  Future _getGoodsInfo(context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
