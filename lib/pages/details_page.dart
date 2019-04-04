import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Provide<DetailInfoProvide>(
                  builder: (context, _, data) => Text('商品id为${json.encode(data.goodsInfo)}')),
            ),
            FlatButton(onPressed: (){    _getGoodsInfo(context);},child: Text('点击获取详情数据'),)
          ],
        ),
      ),
    );
  }

  void _getGoodsInfo(context) async {
    Provide.value<DetailInfoProvide>(context)
        .getGoodsInfo('e47bf468042a4940a3b8a32d07f64d71');
  }
}
