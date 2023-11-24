import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TostMsg {
  displayTostMsg({required String msg, Color? color}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
