import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/constants/import.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, _, provideData) {
        if (provideData.goodsInfo != null &&
            provideData.goodsInfo.data != null &&
            provideData.goodsInfo.data.goodInfo != null) {
          var goodInfo = provideData.goodsInfo.data.goodInfo;
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImg(goodInfo.image1),
                _goodsName(goodInfo.goodsName),
                _goodsNum(goodInfo.goodsSerialNumber),
                _goodsPrice(goodInfo.presentPrice, goodInfo.oriPrice),
              ],
            ),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }

  //商品图片
  Widget _goodsImg(url) {
    return Image.network(
      url,
      width: double.infinity,
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号:$num',
        style:
            TextStyle(color: Colors.black26, fontSize: ScreenUtil().setSp(24)),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
                color: Colors.deepOrangeAccent, fontSize: ScreenUtil().setSp(40)),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(35),
          ),
          Text('市场价：',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenUtil().setSp(30))),
          SizedBox(
            width: ScreenUtil().setWidth(25),
          ),
          Text(
            '￥$oriPrice',
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(35),
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
