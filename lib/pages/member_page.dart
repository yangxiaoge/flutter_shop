import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        behavior: ScrollOverBehavior(),
        child: Center(child: Text('会员中心页面')),
      ),
    );
  }
}
