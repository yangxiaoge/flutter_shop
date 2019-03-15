import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/model/CategoryModel.dart';

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
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                // topCateforyNav(defaultSecondCat),
                Text('哈哈哈'),
                //todo商品列表
              ],
            )
          ],
        ),
      ),
    );
  }

  //商品二级分类
  Widget topCateforyNav(List secondCat) {
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

///左侧商品分类
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];

  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) => _leftInkWellItem(index),
        separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
              height: 1,
            ),
      ),
    );
  }

  Widget _leftInkWellItem(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 0.5, color: Colors.black12))),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
      ),
    );
  }

  void _getCategory() async {
    request(category).then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
    });
  }
}
