import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/model/cartinfo_model.dart';

class CartProvide with ChangeNotifier {
  //购物车商品json数组
  String cartString = '[]';
  List<CartInfoModel> cartInfoList = [];

  ///添加商品
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);

    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int index = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        //购物车已存在，数量加1
        tempList[index]['count'] = item['count'] + 1;
        cartInfoList[index].count++;
        isHave = true;
      }
      index++;
    });

    //新加入购物车的商品
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };

      tempList.add(newGoods);
      cartInfoList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    debugPrint('cartString字符串 = $cartString');
    debugPrint('cartInfoList模型 = $cartInfoList');

    prefs.setString(Constants.cartInfo, cartString);

    notifyListeners();
  }

  ///清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.cartInfo);
    cartInfoList.clear();
    debugPrint('清空成功');

    notifyListeners();
  }

  ///获取购物车商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);
    cartInfoList.clear();
    if (cartString != null) {
      List<Map> tempList = (cartString as List).cast();
      tempList.forEach((item) {
        //把item转成model后加入cartInfoList
        cartInfoList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }
}
