import 'package:chatui/Widgets/list_messages.dart';
import 'package:flutter/material.dart';
import 'package:chatui/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  //ChatScreen({Key? key}) : super(key: key);
  User? user;

  ChatScreen({this.user});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              ListMessages(),
              _buildMessageComposer(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildMessageComposer(BuildContext context) {
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
              textCapitalization: TextCapitalization.sentences,
              decoration:
                  InputDecoration.collapsed(hintText: 'Send Message...'),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            iconSize: 25.0,
          ),
        ],
      ),
    );
  }
}
