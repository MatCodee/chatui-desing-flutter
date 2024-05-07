
import 'dart:convert';

import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/Widgets/small_text.dart';
import 'package:chatui/controllers/user_controller.dart';
import 'package:chatui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomSearchDelegate extends SearchDelegate {
  
  List<dynamic> asks = [];
  bool _dataLoaded = false;
  UserController _userController = UserController();

  @override
  List<Widget> buildActions(BuildContext context) =>  [
    GestureDetector(
      onTap: () {
        showResults(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(Icons.search),
      ),
    )
  ];

  Future<void> _loadDataIfNeeded() async {
    if (!_dataLoaded) {
      try {
        String jsonString = await rootBundle.loadString('assets/json/users.json');
        List<dynamic> jsonData = json.decode(jsonString);
        for (var item in jsonData) {
          asks.add(item['username']);
        }
        _dataLoaded = true;
      } catch (e) {
        print('Error al cargar datos: $e');
      }
    }
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var ask in asks) {
      if(ask.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ask);
      }
    }
    var usersList = [];
    Future.delayed(const Duration(seconds: 3), () async {
      usersList = await _userController.getUsersFilterbyName(matchQuery);
    });
    return ListView.builder(
      itemCount: usersList.length,
      itemBuilder: ((context, index) {
        var user = usersList[index];
        return GestureDetector(
                  onTap: () {
                    Get.to(() => HomeScreen());
                  },
                  child: user != null ? Container(
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
                                  child: SmallText(text: user.status,color: Colors.black54,size: 15,)
                                ),
                              ],
                            ),
                            SizedBox(width: 20,),
                            SmallText(text: "December 14",size: 13,color: Colors.black45,)
                          ],
                        ),

                      ],
                    ),
                  ) : Container(),
                );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: _loadDataIfNeeded(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<dynamic> suggestionList = query.isEmpty
                ? asks : asks.where((result) => result.toLowerCase().contains(query.toLowerCase())).toList();
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //close(context, 'Sugerencia 1 seleccionada');
                    showResults(context);
                    
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 185, 38, 27),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        BigText(text: suggestionList[index],size: 16,),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      );
  }
}