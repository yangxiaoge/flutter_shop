import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style: TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }
}
