import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/models/message_model.dart';
import 'package:chatui/models/user_model.dart';
import 'package:chatui/modelsView/user_model.dart';
import 'package:flutter/material.dart';

class FavoriteContact extends StatelessWidget {
  List<UserContactModel> friend;
  FavoriteContact({required this.friend,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        Container(
          height: 110.0,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: friend.length,
            itemBuilder: (BuildContext context, int index) {
              final UserContactModel user = friend[index];

              return Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          NetworkImage('${user.photo}'),
                    ),
                    const SizedBox(height: 6.0),
                    BigText(text: user.name,size: 13,color: Colors.black,fw: FontWeight.bold,)
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
