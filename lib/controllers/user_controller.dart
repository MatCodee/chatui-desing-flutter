import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/modelsView/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<UserContactModel> usersFriend = [];

  bool _loaded = false;
  bool get loaded => _loaded;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<void> getProfileUser(User user) async {
    QuerySnapshot<Map<String,dynamic>> docRef = await _firebaseFirestore.collection('users').where("uid",isEqualTo: user.uid).get();
    for (QueryDocumentSnapshot doc in docRef.docs) {
      // Accede a los datos del documento y crea un UserModel
      final data = doc.data() as Map<String, dynamic>;
      print(data);
      _userModel = UserModel.fromJson(data);
    }
    _loaded = true;
    getAllUsers(user);
    update();
    
  }

  // traer informacion de otros usuarios
  Future<void> getAllUsers(User user) async {
    try {
      if (_userModel != null) {
        final List<dynamic> list_friend = _userModel.friends;
          usersFriend.clear();

        for (var t in list_friend) {
          final DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(t).get();
          final data = doc.data() as Map<String, dynamic>;
          print(data['photo']);
          usersFriend.add(UserContactModel.fromJson(data));
        }
        //print(usersFriend);
        update();
      }
    } catch (e) {
      print(e);
    }
  }
  // agregar otros usuarios
}
