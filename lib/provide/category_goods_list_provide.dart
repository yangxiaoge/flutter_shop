import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goodslist_model.dart';

class CategoryGoodsListProvide extends ChangeNotifier {
  List<CategoryListData> childCategoryGoodsList = [];

  ///点击大类时，重新更新商品列表
  setCategoryGoodsList(List<CategoryListData> list) {
    childCategoryGoodsList
      ..clear()
      ..addAll(list);

    notifyListeners();
  }
}
