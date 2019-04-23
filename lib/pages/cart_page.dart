import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CartInfoModel> cartList =
                Provide.value<CartProvide>(context).cartList;
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return CartItem(cartList[index]);
              },
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
