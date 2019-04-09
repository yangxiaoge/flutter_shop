import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Material(
              child: Ink(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    debugPrint('购物车');
                    Toast.show(context, '购物车');
                  },
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Material(
              child: Ink(
                color: Colors.green,
                child: InkWell(
                  onTap: () {
                    debugPrint('加入购物车');
                    Toast.show(context, '加入购物车');
                  },
                  child: Center(
                      child: Text(
                    '加入购物车',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Material(
                child: Ink(
                  color: Colors.red,
                  // width: 200.0,
                  // height: 100.0,
                  child: InkWell(
                      // splashColor: Colors.grey,
                      onTap: () {
                        debugPrint('立即购买');
                        Toast.show(context, '立即购买');
                      },
                      child: Center(
                        child: Text(
                          '立即购买',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
