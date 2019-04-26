import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ScreenUtil().setHeight(130),
      padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(10),
          top: ScreenUtil().setWidth(5),
          bottom: ScreenUtil().setWidth(5)),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, _, val) {
          return Row(
            children: <Widget>[
              _selectAll(context, val.selectAll),
              Expanded(
                child: _totalPrice(context),
              ),
              _pay(context),
            ],
          );
        },
      ),
    );
  }

  ///全选
  Widget _selectAll(context, selectAll) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: selectAll,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (checked) async {
              await Provide.value<CartProvide>(context)
                  .selectAllCheckState(checked);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  ///总价
  Widget _totalPrice(context) {
    double totalPrice = Provide.value<CartProvide>(context).totalPrice;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计:',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  // '￥${totalPrice}',
                  '￥${totalPrice.toStringAsFixed(1)}',
                  style: TextStyle(
                      color: Colors.red, fontSize: ScreenUtil().setSp(36)),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          ),
        ],
      ),
    );
  }

  ///结算
  Widget _pay(context) {
    // return Container(
    //   padding: EdgeInsets.only(left: 10),
    //   child: InkWell(
    //     onTap: () {},
    //     child: Container(
    //       padding: EdgeInsets.all(10),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(3.0),
    //         color: Colors.red,
    //       ),
    //       child: Text(
    //         '结算(6)',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     ),
    //   ),
    // );

    // return Container(
    //   margin: EdgeInsets.only(left: ScreenUtil().setWidth(10),),
    //   width: ScreenUtil().setWidth(160),
    //   child: RaisedButton(
    //     elevation: 0,
    //     padding: EdgeInsets.all(1),
    //     onPressed: () {},
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
    //     color: Colors.red,
    //     child: Text(
    //       '结算(100)',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );
    int totalCount = Provide.value<CartProvide>(context).totalCount;
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: RaisedButton(
        elevation: 0,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        color: Colors.red,
        child: Text(
          '结算($totalCount)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
