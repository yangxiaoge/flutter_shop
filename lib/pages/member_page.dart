import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/widget/member_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/constants/import.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  // 交互通道名字
  final String _channel = "com.bruce.flutter_shop/channel";

  // 支付宝
  final String _alipay = "aliPay";

  // 交互通道
  MethodChannel _nativeChannel;

  @override
  void initState() {
    super.initState();
    //监听渠道CHANNEL
    _nativeChannel = MethodChannel(_channel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        behavior: ScrollOverBehavior(),
        child: ListView(
          children: <Widget>[
            Center(child: Text('会员中心页面')),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Container(
                color: Colors.black12,
              ),
            ),
            ListItem(
//              icon: Image.asset("assets/img/alipay.png"),
              icon: ImageIcon(
                AssetImage("assets/img/alipay.png"),
                color: Color(0xff1296db),
              ),
              onPressed: () {
                _nativeChannel.invokeMethod(_alipay).then((success) {
                  print('支付宝 success = $success');
                  if(!success){
                   Toast.show(context, '您没有安装支付宝！');
                  }else{
                    Toast.show(context, '打开支付宝');
                  }
                });
              },
              title: '支付宝付款',
            )
          ],
        ),
      ),
    );
  }
}
