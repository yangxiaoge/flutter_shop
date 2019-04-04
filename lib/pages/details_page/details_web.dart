import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (cntext, _, provideData) {
        bool isLeft = provideData.isLeft;
        if (isLeft) {
          if (provideData.goodsInfo != null &&
              provideData.goodsInfo.data != null &&
              provideData.goodsInfo.data.goodInfo != null) {
            var goodsDetailHtml =
                provideData.goodsInfo.data.goodInfo.goodsDetail;
            return Container(
              child: Html(
                data: goodsDetailHtml,
              ),
            );
          } else {
            return CupertinoActivityIndicator();
          }
        } else {
          return Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text('暂时没有数据'));
        }
      },
    );
  }
}
