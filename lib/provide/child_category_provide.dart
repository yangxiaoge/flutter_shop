import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

///分类页 - 子分类provide
class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = []; //子类分类
  int selectChildCategoryIndex = 0; //子类下标
  String categoryId = '4'; //大类id
  String categorySubId = ''; //子类id
  int goodsListPage = 1; //商品列表页码
  String noMoreText = ''; //没有商品时展示的文字

  //全部-公用的，用final定义即可
  final BxMallSubDto _all = BxMallSubDto(
      mallSubId: '', mallCategoryId: '', mallSubName: '全部', comments: null);

  setChildCategory(List<BxMallSubDto> list, String categoryId) {
    //点击左侧大类时，需要重置右上角商品分类当前选中的index
    this.selectChildCategoryIndex = 0;
    this.categoryId = categoryId;
    this.categorySubId = '';
    this.goodsListPage = 1;
    this.noMoreText = '';

    childCategoryList
      ..clear()
      ..add(_all) //在分类头部增加"全部"分类
      ..addAll(list);

    notifyListeners();
  }

  //点击子分类
  setChildSelectCategoryIndex(int selectIndex, String categorySubId) {
    //防止重复点击
    if (selectChildCategoryIndex != selectIndex) {
      this.selectChildCategoryIndex = selectIndex;
      this.categorySubId = categorySubId;
      this.goodsListPage = 1;
      this.noMoreText = '';

      notifyListeners();
    }
  }

  //商品列表页面page增加
  addPage() {
    goodsListPage++;
  }

  //没有商品时展示的文字
  changeNomoreText(String msg) {
    this.noMoreText = msg;

    notifyListeners();
  }
}
