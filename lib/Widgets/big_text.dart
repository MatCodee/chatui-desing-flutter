import 'package:flutter/material.dart';


class BigText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double size;
  final FontWeight fw;
  final TextOverflow overFlow;


  const BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    this.size = 20, 
    this.fw = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'default label incase label is null',
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(fontSize: size,color: color,fontWeight: fw),
    );
  }
}