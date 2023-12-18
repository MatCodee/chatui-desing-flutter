import 'package:chatui/Widgets/favorite_contact.dart';
import 'package:chatui/Widgets/list_messages.dart';
import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/controllers/chat_controller.dart';
import 'package:chatui/modelsView/message_model.dart';
import 'package:chatui/modelsView/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  //ChatScreen({Key? key}) : super(key: key);
  UserContactModel user;
  TextEditingController message = TextEditingController();

  ChatScreen({required this.user});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find<AuthController>();
    ChatController _chatController = Get.find<ChatController>();


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          '${widget.user?.name}',
          style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<ChatController>(builder: (chatController) {
        return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
             FutureBuilder<List<Message>>(
                future: _chatController.getmessages(_authController.user.value!.uid, widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Message> messages = snapshot.data!;
                    return ListMessages(messages: messages);
                  }
                },
              ), 
            ],
          ),
        ),
      );
      }),
      bottomNavigationBar: Container(
        child: _buildMessageComposer(context,_authController, _chatController),
      ),
    );
  }

  _buildMessageComposer(BuildContext context, AuthController authController,ChatController chatController) {
    return Container(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 30.0, top: 10.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.photo),
            color: Theme.of(context).primaryColor,
            iconSize: 25.0,
          ),
          Expanded(
            child: TextField(
              controller: widget.message,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration.collapsed(hintText: 'Send Message...'),
            ),
          ),
          IconButton(
            onPressed: () {
              String sender = authController.getCurrentUser()!.uid;
              String des = widget.user.uid;
              String text = widget.message.text.trim();
              print(text);
              chatController.createMessage(sender, des, text);
              widget.message.text = "";
            },
            icon: const Icon(Icons.send),
            color: Colors.pink,
            iconSize: 25.0,
          ),
        ],
      ),
    );
  }
}
