import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_model.dart';

class ChildCategoryProvide extends ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List list) {
    childCategoryList = list;
    notifyListeners();
  }
}
