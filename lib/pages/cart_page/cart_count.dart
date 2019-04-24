import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CartCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(),
          _countText(),
          _addBtn(),
        ],
      ),
    );
  }

  /// - 号按钮
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Text('-'),
      ),
    );
  }

  /// + 号按钮
  Widget _addBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Text('+'),
      ),
    );
  }

  ///数量
  Widget _countText() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('8'),
    );
  }
}
