import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  CartItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          )),
      child: Row(
        children: <Widget>[
          _checkBox(context),
          _cartImg(),
          _cartGoodsName(),
          _cartPrice(context),
        ],
      ),
    );
  }

  ///checkbox
  Widget _checkBox(context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (checked) {},
      ),
    );
  }

  ///商品图片
  Widget _cartImg() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Image.network(item.images),
    );
  }

  ///商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  ///商品价格
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('￥ ${item.price}'),
          Container(
            child: InkWell(
              onTap: () async {
                //删除这个商品
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black26,
              ),
            ),
          )
        ],
      ),
    );
  }
}
