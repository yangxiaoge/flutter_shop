import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CategoryPage extends StatelessWidget {
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
                MallGoodsList(),
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
    //为了第一次能加载商品列表
    _getGoodsList();
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
        //同一个tab多次点击忽略不处理
        if (_selectLeftCategoryIndex != index) {
          setState(() {
            _selectLeftCategoryIndex = index;
          });

          var childLsit = list[index].bxMallSubDto;
          var categoryId = list[index].mallCategoryId;
          //更新右上角商品分类
          Provide.value<ChildCategoryProvide>(context)
              .setChildCategory(childLsit);

          //右上角分类滚动到下标0位置
          _controller.animateTo(0,
              duration: Duration(milliseconds: 200), curve: Curves.ease);
          //商品列表请求
          _getGoodsList(categoryId: categoryId);
        }
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
    await request(category).then((val) {
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

  _getGoodsList({String categoryId}) async {
    //categoryId: 大类 ID，字符串类型
    //categorySubId : 子类 ID，字符串类型，如果没有可以填写空字符串，例如 ''
    //page: 分页的页数，int 类型
    var formData = {
      'categoryId': categoryId ?? '4',
      'categorySubId': '',
      'page': 1
    };
    await request(getMallGoods, formData: formData).then((val) {
      var data = json.decode(val.toString());
      // debugPrint('商品列表-------->$data');
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);
      //provide通知刷新商品列表
      Provide.value<CategoryGoodsListProvide>(context)
          .setCategoryGoodsList(categoryGoodsListModel.data);
    });
  }
}

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
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) => Container(
            width: ScreenUtil().setWidth(550),
            height: ScreenUtil().setHeight(90),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) => _rightInkWellItem(
                  index, childCategory.childCategoryList[index]),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1))),
          ),
    );
  }

  Widget _rightInkWellItem(int index, BxMallSubDto item) {
    return Provide<ChildCategoryProvide>(
      builder: (context, _, data) {
        return InkWell(
          onTap: () {
            setState(() {
              Provide.value<ChildCategoryProvide>(context)
                  .setChildSelectCategoryIndex(index);
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
                  color: data.selectChildCategoryIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                )),
          ),
        );
      },
    );
  }
}

///商品列表
class MallGoodsList extends StatefulWidget {
  @override
  _MallGoodsListState createState() => _MallGoodsListState();
}

class _MallGoodsListState extends State<MallGoodsList> {
  int pageIndex = 1;
  // List<CategoryListData> goodsList = [];

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, _, data) {
        return Expanded(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(550),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[_goodsList(data.childCategoryGoodsList)],
            ),
          ),
        );
      },
    );
  }

  Widget _goodsList(List goodsList) {
    return Wrap(
      children: goodsList.map((goodsItem) {
        return InkWell(
          onTap: () {
            debugPrint('火爆商品item: ${goodsItem.goodsName}');
          },
          child: Container(
            width: ScreenUtil.getInstance().setWidth(275),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Image.network(
                  goodsItem.image,
                  width: ScreenUtil().setWidth(275),
                ),
                Text(
                  goodsItem.goodsName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil.getInstance().setSp(24)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '￥${goodsItem.oriPrice}',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '￥${goodsItem.presentPrice}',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: ScreenUtil.getInstance().setSp(24),
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
