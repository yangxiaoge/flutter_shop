import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';
///分类页 - 子分类provide
class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  //全部-公用的，用final定义即可
  final BxMallSubDto _all = BxMallSubDto(
      mallSubId: '0', mallCategoryId: '0', mallSubName: '全部', comments: null);

  setChildCategory(List<BxMallSubDto> list) {
    //在分类头部增加"全部"分类

    childCategoryList
      ..clear()
      ..add(_all)
      ..addAll(list);

    notifyListeners();
  }
}
