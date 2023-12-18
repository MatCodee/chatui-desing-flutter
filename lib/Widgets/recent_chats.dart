import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/Widgets/small_text.dart';
import 'package:chatui/models/message_model.dart';
import 'package:chatui/modelsView/user_model.dart';
import 'package:chatui/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class RecentChats extends StatelessWidget {
  List<UserContactModel> friend;
  RecentChats({required this.friend,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
              itemCount: friend.length,
              itemBuilder: (BuildContext context, int index) {
                final UserContactModel user = friend[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => ChatScreen(user:user));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 5.0, bottom: 5.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(20),
         
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    NetworkImage(user.photo)),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: user.name,fw: FontWeight.bold,size: 18,),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: SmallText(text: 'Awesome song! 🥶',color: Colors.black54,size: 15,)
                                ),
                              ],
                            ),
                            SizedBox(width: 20,),
                            SmallText(text: "December 14",size: 13,color: Colors.black45,)
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
