import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  setChildCategory(List<BxMallSubDto> list) {
    //在分类头部增加"全部"分类
    BxMallSubDto all = BxMallSubDto(
        mallSubId: '0', mallCategoryId: '0', mallSubName: '全部', comments: null);
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
