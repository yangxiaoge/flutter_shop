import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

///购物车商品，+，-数量组件
class CartCount extends StatelessWidget {
  final CartInfoModel item;
  CartCount(this.item);
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
          _reduceBtn(context),
          _countText(),
          _addBtn(context),
        ],
      ),
    );
  }

  /// - 号按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () async {
        Provide.value<CartProvide>(context).decreaseGoodCount(item.goodsId);
      },
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
  Widget _addBtn(context) {
    return InkWell(
      onTap: () async {
        Provide.value<CartProvide>(context).increaseGoodCount(item.goodsId);
      },
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
      child: Text('${item.count}'),
    );
  }
}
