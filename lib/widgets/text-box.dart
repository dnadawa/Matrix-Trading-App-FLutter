import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType type;

  const TextBox({Key key, this.hint='', this.controller, this.isPassword=false, this.type=TextInputType.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: EdgeInsets.fromLTRB(10,15,10,15),
      keyboardType: type,
      controller: controller,
      obscureText: isPassword,
      placeholder: hint,


    );
  }
}
