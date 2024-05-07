import 'package:flutter/material.dart';


class SmallText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double size;
  final double height;
  final FontWeight fw;

  const SmallText({
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