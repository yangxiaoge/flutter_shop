import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/model/cartinfo_model.dart';

class CartProvide with ChangeNotifier {
  //购物车商品json数组
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  //商品总价
  double totalPrice = 0;
  //商品总数
  int totalCount = 0;

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
        cartList[index].count++;
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
        'images': images,
        'isCheck': true
      };

      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    debugPrint('cartString字符串 = $cartString');
    // debugPrint('cartInfoList模型 = $cartList');

    prefs.setString(Constants.cartInfo, cartString);

    //重新获取购物车商品
    getCartInfo();
  }

  ///清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.cartInfo);
    cartList.clear();
    debugPrint('清空成功');

    //重新获取购物车商品
    getCartInfo();
  }

  ///获取购物车商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);
    cartList.clear();

    //先置0,防止出错
    totalPrice = 0;
    totalCount = 0;

    if (cartString != null) {
      //json.decode，防止直接转List会有问题
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        //计算总价/总数
        totalPrice += item['price'] * item['count'];
        totalCount += item['count'];

        //把item转成model后加入cartInfoList
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  ///删除某个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(deleteIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString(Constants.cartInfo, cartString);

    //重新获取购物车商品
    getCartInfo();
  }

  ///增加某个商品数量
  increaseGoodCount(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        item['count']++;
      }
    });
    cartString = json.encode(tempList).toString();
    prefs.setString(Constants.cartInfo, cartString);

    //重新获取购物车商品
    getCartInfo();
  }

  ///减少某个商品数量
  decreaseGoodCount(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString(Constants.cartInfo);

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        //数量至少有1个
        if (item['count'] >= 2) {
          item['count']--;
        }
      }
    });
    cartString = json.encode(tempList).toString();
    prefs.setString(Constants.cartInfo, cartString);

    //重新获取购物车商品
    getCartInfo();
  }
}
