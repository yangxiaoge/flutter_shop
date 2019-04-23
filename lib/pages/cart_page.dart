import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('添加'),
            onPressed: () {
              _add();
            },
          ),
          RaisedButton(
            child: Text('删除'),
            onPressed: () {
              _clear();
            },
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                  leading: Icon(Icons.ac_unit),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = '小羊最帅！！！';
    testList.add(temp);
    prefs.setStringList('cartInfo', testList);
    _show();
  }

  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('cartInfo') != null) {
      setState(() {
        testList = prefs.getStringList('cartInfo');
      });
    }
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    prefs.remove('cartInfo');
    setState(() {
      testList = [];
    });
  }
}
