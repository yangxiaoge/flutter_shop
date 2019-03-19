import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/model/category_model.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightTopCategoryNav(),
                Text('哈哈哈'),
                //todo商品列表
              ],
            )
          ],
        ),
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
  //当前左侧分类选中的下标
  int _selectLeftCategoryIndex = 0;

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
      onTap: () {
        //更新子分类（右上角商品分类）
        var childLsit = list[index].bxMallSubDto;
        Provide.value<ChildCategoryProvide>(context)
            .setChildCategory(childLsit);

        setState(() {
          _selectLeftCategoryIndex = index;
        });

        //右上角分类下标重置
        _selectRightCategoryIndex = 0;

        //右上角分类滚动到下标0位置
        _controller.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      child: Container(
        decoration: BoxDecoration(
            color: _selectLeftCategoryIndex == index
                ? Colors.black12
                : Colors.white,
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
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
      //设置右上角分类默认项
      Provide.value<ChildCategoryProvide>(context)
          .setChildCategory(list[0].bxMallSubDto);
    });
  }
}

///当前右上角商品分类选中的下标
int _selectRightCategoryIndex = 0;

///右上角商品分类滚动监听
ScrollController _controller = new ScrollController();

///右上角商品分类
class RightTopCategoryNav extends StatefulWidget {
  @override
  __RightTopCategoryNavState createState() => __RightTopCategoryNavState();
}

class __RightTopCategoryNavState extends State<RightTopCategoryNav> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(550),
      height: ScreenUtil().setHeight(90),
      child: Provide<ChildCategoryProvide>(
        builder: (context, child, childCategory) {
          return ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) => _rightInkWellItem(
                index, childCategory.childCategoryList[index]),
          );
        },
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
    );
  }

  Widget _rightInkWellItem(int index, BxMallSubDto item) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectRightCategoryIndex = index;
        });
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        alignment: Alignment.center,
        child: Text(item.mallSubName,
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(30),
              color: _selectRightCategoryIndex == index
                  ? Theme.of(context).primaryColor
                  : Colors.black,
            )),
      ),
    );
  }
}
