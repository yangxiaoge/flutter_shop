import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/constants/import.dart';

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
              return Container(
                child: Column(
                  children: <Widget>[],
                ),
              );
            } else {
              return CupertinoActivityIndicator();
            }
          },
        ));
  }

  Future _getGoodsInfo(context) async {
    await Provide.value<DetailInfoProvide>(context)
        .getGoodsInfo('e47bf468042a4940a3b8a32d07f64d71');
    return '完成加载';
  }
}
