import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CartProvide with ChangeNotifier {
  //购物车商品json数组
  String cartString = '[]';

  ///添加商品
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int index = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        //已存在数量加1
        tempList[index]['count'] = item['count'] + 1;
        isHave = true;
      }
      index++;
    });

    //新加入购物车的商品
    if (!isHave) {
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });
    }

    cartString = json.encode(tempList).toString();
    debugPrint('cartString = $cartString');

    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  ///清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    debugPrint('清空成功');

    notifyListeners();
  }
}
