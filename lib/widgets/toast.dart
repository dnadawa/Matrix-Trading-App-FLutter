import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastBar{

  final String text;
  final Color color;

  ToastBar({this.text, this.color});

  show(){
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}