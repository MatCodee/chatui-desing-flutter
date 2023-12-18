import 'package:chatui/modelsView/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late List<Message> _messages = [];
  List<Message> get messages => _messages;

  Future<List<Message>> getmessages(String sender, String des) async {
    try {
      // sender
      _messages.clear();
      final QuerySnapshot<Map<String,dynamic>> query =  await _firebaseFirestore.collection('messages')
          .where('sender', isEqualTo: sender)
          .where('des', isEqualTo: des).get();
      //print(query.docs.length);
      //print(query.docs);

      for(var doc in query.docs) {
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        _messages.add(Message.fromJson(data));
      }



      // receiver
      final QuerySnapshot<Map<String,dynamic>> query2 =  await _firebaseFirestore.collection('messages')
          .where('sender', isEqualTo: des)
          .where('des', isEqualTo: sender).get();
      //print(query.docs.length);
      //print(query.docs);
      // TODO: Ordenar los receiver 
      for(var doc in query2.docs) {
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        _messages.add(Message.fromJson(data));
      }

      print(_messages);
      
      // TODO: Ordenar los mensajes en base a fecha
      //_messages.sort((a, b) => a.time!.compareTo(b.time!));



      print(_messages);
      return _messages;
    } catch (error) {
      print(error);
    }
    return _messages;
  }

  // Send Messgae
  Future<void> createMessage(String sender, String des,String text) async {
    final form = {
      'sender': sender,
      'isliked': false,
      'text': text,
      'des': des,
      'time': DateTime.now(),
      'unread': false,
    };
    print(form);
    try {
      await _firebaseFirestore.collection('messages').add(form);
      _messages.add(Message.fromJson(form));
    } catch(e) {
      print(e);
    }
    update();
  }
  // Liked message


  

}