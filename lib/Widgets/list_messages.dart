import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/modelsView/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMessages extends StatelessWidget {
  List<Message> messages;
  ListMessages({required this.messages,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Get.find<AuthController>().getCurrentUser();

    return Expanded(
      child: Container(
        decoration:const  BoxDecoration(
          color: Colors.white,
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
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                final bool isMe = message.sender == user!.uid;
                return _buildMessage(context, message, isMe);
              }),
        ),
      ),
    );
  }

  _buildMessage(BuildContext context, Message message, bool isMe) {
    return Container(
        margin: isMe == true
            ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
            : const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        decoration: BoxDecoration(
            color: isMe == true
                ? Theme.of(context).colorScheme.secondary
                : Color.fromARGB(255, 255, 243, 255),
            borderRadius: isMe == true
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0))
                : const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.time != null ? '${message.time}': "Mensaje" ,
              style:  TextStyle(
                  fontSize: 16.0,
                  color: isMe == true  ? Color.fromARGB(255, 255, 255, 255)  : Color.fromARGB(255, 100, 100, 100),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${message.text}',
              style:  TextStyle(
                  fontSize: 16.0,
                  color: isMe == true  ? Color.fromARGB(255, 255, 255, 255)  : Color.fromARGB(255, 106, 106, 106),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }
}
