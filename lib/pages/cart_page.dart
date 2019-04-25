import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/pages/cart_page/cart_bottom.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          List cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData && cartList != null) {
            return Column(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, _, val) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: val.cartList.length,
                        itemBuilder: (context, index) {
                          return CartItem(val.cartList[index]);
                        },
                      ),
                    );
                  },
                ),
                CartBottom(),
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
