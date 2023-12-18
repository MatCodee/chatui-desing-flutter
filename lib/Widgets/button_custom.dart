import 'package:chatui/Widgets/big_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  dynamic press; // function button
  String title;

  CustomButton({super.key, required this.press, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.blue,
        ),
        child: Center(
            child: BigText(
          text: title,
          size: 25,
          color: Colors.white,
        )),
      ),
    );
  }
}
