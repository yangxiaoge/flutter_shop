import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastHelper {
  /// 显示 Snackbar
  // static void showSnack(BuildContext context, String msg) {
  //   Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }

  /// 显示 Toast
  static show(String text) {
    Fluttertoast.showToast(msg: text);
  }

  static showLongToast(String text) {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_LONG);
  }

  static showShortToast(String text) {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT);
  }

  static showCenterShortToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(28),
        timeInSecForIos: 1);
  }

  static showTopShortToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1);
  }

  static cancelToast() {
    Fluttertoast.cancel();
  }
}
