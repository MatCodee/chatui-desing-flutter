import 'package:flutter/material.dart';


class SmallText extends StatelessWidget {
  Color? color;
  final String? text;
  double size;
  double height;
  FontWeight fw;

  SmallText({
    super.key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12, 
    this.height = 1.2,
    this.fw = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'default label incase label is null',
      style: TextStyle(fontSize: size,height: height,color: color,fontWeight: fw),
    );
  }
}