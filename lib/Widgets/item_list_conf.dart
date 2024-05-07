
import 'package:chatui/Widgets/small_text.dart';
import 'package:flutter/material.dart';


class ItemListConf extends StatelessWidget {
  final String title;
  final IconData icon;

  const ItemListConf({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Color.fromARGB(255, 179, 179, 179)))
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Expanded(child:SmallText(text: title,size: 16,)),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}