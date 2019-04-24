import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(130),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _selectAll(context),
          Expanded(
            child: _totalPrice(),
          ),
          _pay(),
        ],
      ),
    );
  }

  ///全选
  Widget _selectAll(context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (checked) {},
          ),
          Text('全选'),
        ],
      ),
    );
  }

  ///总价
  Widget _totalPrice() {
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
                  '￥1992',
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
  Widget _pay() {
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

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: RaisedButton(
        elevation: 0,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        color: Colors.red,
        child: Text(
          '结算(100)',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
