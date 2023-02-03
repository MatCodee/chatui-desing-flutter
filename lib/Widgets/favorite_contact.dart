import 'package:chatui/models/message_model.dart';
import 'package:chatui/models/user_model.dart';
import 'package:flutter/material.dart';

class FavoriteContact extends StatelessWidget {
  const FavoriteContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 30.0,top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Favorite Contact",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.blueGrey,
                  letterSpacing: 1.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                color: Colors.blueGrey,
                iconSize: 30.0,
              ),
            ],
          ),
        ),
        Container(
          height: 120.0,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          AssetImage('${favorites[index].imageUrl}'),
                    ),
                    const SizedBox(height: 6.0),
                    Text('${favorites[index].name}',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
