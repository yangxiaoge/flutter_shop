import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //当前一级分类选中的下标
  int _selectCategoryIndex = 0;
  //当前二级分类选中的下标
  int _selectSecondCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: request(category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> cat = (data['data'] as List).cast();
            List<Map> defaultSecondCat =
                (data['data'][0]['bxMallSubDto'] as List).cast();
            return Row(
              children: <Widget>[
                firstGoodsCategory(cat),
                Column(
                  children: <Widget>[
                    secondGoodsCatefory(defaultSecondCat),
                    Text('哈哈哈'),
                    //todo商品列表
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28)),
              ),
            );
          }
        },
      ),
    );
  }

  //商品一级分类
  Widget firstGoodsCategory(List goodsCategory) {
    Widget _divider = Divider(
      color: Colors.black12,
      height: 1,
    );
    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black12, width: 1))),
      width: ScreenUtil.getInstance().setWidth(187), //750/4 = 187.5
      child: ListView.separated(
        shrinkWrap: true,
        primary: true,
        itemCount: goodsCategory.length,
        itemBuilder: (context, index) {
          return Container(
            color: _selectCategoryIndex == index ? Colors.black12 : null,
            child: ListTile(
              // selected: _selectCategoryIndex == index,
              title: Text(
                goodsCategory[index]['mallCategoryName'],
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(28),
                ),
              ),
              onTap: () {
                if (_selectCategoryIndex != index) {
                  setState(() {
                    _selectCategoryIndex = index;
                  });
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return _divider;
        },
      ),
    );
  }

  //商品二级分类
  Widget secondGoodsCatefory(List secondCat) {
    return Container(
      width: ScreenUtil().setWidth(563),
      height: ScreenUtil().setHeight(90),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: ListView.builder(
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.horizontal,
        itemCount: secondCat.length,
        itemBuilder: (context, index) {
          return Container(
            width: ScreenUtil.getInstance().setWidth(150),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              selected: _selectSecondCategoryIndex == index,
              onTap: () {
                if (_selectSecondCategoryIndex != index) {
                  setState(() {
                    _selectSecondCategoryIndex = index;
                  });
                }
              },
              title: Center(
                child: Container(
                  child: Text(
                    secondCat[index]['mallSubName'],
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(26),
                    ),
                  ),
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
