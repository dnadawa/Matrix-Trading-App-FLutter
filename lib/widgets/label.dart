import 'package:flutter/material.dart';

class Lable extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextAlign align;

  const Lable({Key key, this.text, this.size=14, this.color=Colors.black, this.align=TextAlign.start}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: size,
          color: color,
      ),
      textAlign: align,
    );
  }
}
