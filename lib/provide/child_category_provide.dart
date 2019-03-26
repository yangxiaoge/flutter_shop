import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

///分类页 - 子分类provide
class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  //子类下标
  int selectChildCategoryIndex = 0;
  //大类id
  String categoryId = '4';

  //全部-公用的，用final定义即可
  final BxMallSubDto _all = BxMallSubDto(
      mallSubId: '', mallCategoryId: '', mallSubName: '全部', comments: null);

  setChildCategory(List<BxMallSubDto> list,String categoryId) {
    //点击左侧大类时，需要重置右上角商品分类当前选中的index
    selectChildCategoryIndex = 0;
    this.categoryId = categoryId;

    childCategoryList
      ..clear()
      ..add(_all) //在分类头部增加"全部"分类
      ..addAll(list);

    notifyListeners();
  }

  //点击子分类
  setChildSelectCategoryIndex(int selectIndex,String categorySubId) {
    if (selectChildCategoryIndex != selectIndex) {
      selectChildCategoryIndex = selectIndex;
      notifyListeners();
    }
  }
}
