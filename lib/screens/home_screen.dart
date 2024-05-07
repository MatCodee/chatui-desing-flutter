import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/Widgets/category_selector.dart';
import 'package:chatui/Widgets/custom_search_delegate.dart';
import 'package:chatui/Widgets/favorite_contact.dart';
import 'package:chatui/Widgets/recent_chats.dart';
import 'package:chatui/Widgets/small_text.dart';
import 'package:chatui/controllers/auth_controller.dart';
import 'package:chatui/controllers/user_controller.dart';
import 'package:chatui/models/message_model.dart';
import 'package:chatui/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find<AuthController>();
    UserController _userController = Get.find<UserController>();    
    

    final User? currentUser = _authController.user.value;
    if (currentUser == null) {
      Get.snackbar("No Autenticado", "No Auth");
    } else {
      print(currentUser.uid);
       _userController.getProfileUser(currentUser);
    }
    

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      /*
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      */
      body: GetBuilder<UserController>(builder: (userController) {
        return  userController.loaded ? SafeArea(
          child: Column(
          children: <Widget>[
            //CategorySelector(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${_userController.userModel.photo}'),
                                        ),
                    ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(text: "Buenos Dias",size: 15,color: Colors.black45,),
                      BigText(text: _userController.userModel.name,size: 24,),
                    ],
                  ),
                    ],
                  ),
                  Row(
                    children: [
                     GestureDetector(
                        onTap: (){
                          //_authController.signOut();
                          showSearch(context: context, delegate: CustomSearchDelegate());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 156, 189),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.search,color: Colors.white,),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      /*
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                      */
               
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            FavoriteContact(friend: userController.usersFriend),
            Expanded(
              child: Container(
                height: 500.0,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)),
                ),
                child: Column(
                  children: <Widget> [
                    //FavoriteContact(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: "Chats",size: 30,color: Colors.black,fw: FontWeight.bold,),
                          SmallText(text: "Manage",size: 15,color: Colors.black54,fw: FontWeight.bold,)
                        ],
                      ),
                    ),
                    RecentChats(friend: userController.usersFriend)
                  ],
                ),
              ),
            ),
          ],
                ),
        ) : const Center(child: CircularProgressIndicator(),);
      })
    );
  }
}
