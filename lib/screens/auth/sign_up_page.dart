import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/Widgets/button_custom.dart';
import 'package:chatui/Widgets/input_field.dart';
import 'package:chatui/Widgets/small_text.dart';
import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/screens/auth/sign_in_page.dart';
import 'package:chatui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  AuthController _authController = AuthController();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 200,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                BigText(text: "Registrate!",size: 30,color: Colors.black54,),
                const SizedBox(height: 20,),
                InputFieldText(textController: _name, hintText: "Name", icon: Icons.person),
                const SizedBox(height: 20,),
                InputFieldText(textController: _email, hintText: "Email", icon: Icons.email),
                const SizedBox(height: 20,),
                InputFieldText(textController: _password, hintText: "Password", icon: Icons.password),
                const SizedBox(height: 20,),
                CustomButton(press: register, title: "Register"),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () => Get.to(() => SignInPage()),
                  child: SmallText(text: "O iniciar sesión",size: 18,color: Colors.black54,),
                ),
                const SizedBox(height: 20,),
                SmallText(text: "Iniciar Sesion con Google",size: 20,color: Colors.black54,),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () => googleAuth(),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const  Image(
                      image: NetworkImage('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // cambiar a aqui a registro con google
  void googleAuth() async {
    bool response = await _authController.handlerGoogleSignIn();
    if (response) {
      Get.to(() => const HomeScreen());
    }
  }

  void register() async {
    String email = _email.text.trim();
    String password = _password.text.trim();
    String name = _name.text.trim();

    if(email.isNotEmpty && password.isNotEmpty) {
      bool data = await _authController.signUpEmailandPassword(email, password,name);
      if(data) {
        Get.to(() => const HomeScreen());
      }
    }  
  }
}