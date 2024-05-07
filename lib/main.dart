import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/controllers/chat_controller.dart';
import 'package:chatui/controllers/user_controller.dart';
import 'package:chatui/screens/auth/sign_in_page.dart';
import 'package:chatui/screens/auth/sign_up_page.dart';
import 'package:chatui/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put<AuthController>(AuthController());
    Get.put<UserController>(UserController());
    Get.put<ChatController>(ChatController());

    return GetMaterialApp(
      title: 'Flutter Chat UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 241, 252),
      ),
      home: const Center(child: CircularProgressIndicator()),
    );
  }
}


