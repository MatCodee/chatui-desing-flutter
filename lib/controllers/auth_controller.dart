import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Rx<User?> user = Rx<User?>(null);
  //late User? user;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    _firebaseAuth.authStateChanges().listen((User? firebaseuser) {
      user.value = firebaseuser;
    });
    super.onInit();
  }

  Future<bool> signUpEmailandPassword(String email, String password,String name) async {
    try {
      print("Entro aqui");
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;

      // add user information to database
      if(user.value != null) {
        final form = {
          'name': name,
          'email': email,
          'photo': user.value?.photoURL ?? '',
          'uid': user.value?.uid,
          'friends': [],
        };
        db.collection('users').doc(user.value?.uid).set(form);
      }

      return true;
    } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
    }
    catch (e) {
      print(e);
    }
    return false;
  }
  
  Future<bool> signInEmailAndPassword(String email,String password) async {
    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;
      print(user);
      Get.snackbar("exito al entrar","entrar");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // Implementation google:
  // Registration google account:

  // login:
  Future<bool> handlerGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser =  await _googleSignIn.signIn();
      if(googleUser == null) return false; // cancelo el inicio de sesion

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      
      if(user != null) {
        print("Usuario autenticado con exito");
        // lanzar notificacion
        return true;
      } else {
        // Algo salio mal 
        // lanzar notificacion de error
        return false;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }
  Future<void> _handleGoogleSignOut() => _googleSignIn.disconnect();

}