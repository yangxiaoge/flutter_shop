import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail_model.dart';
import 'package:flutter_shop/constants/import.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailModel goodsInfo = null;

  //从后台获取商品详情数据
  getGoodsInfo(String goodId) {
    var formData = {'goodId': goodId};

    request(getGoodDetailById, formData: formData).then((val) {
      var response = json.decode(val.toString());
      debugPrint(response.toString());
      goodsInfo = DetailModel.fromJson(response);

      notifyListeners();
    });
  }
}
