import 'package:chatui/Widgets/big_text.dart';
import 'package:chatui/Widgets/item_list_conf.dart';
import 'package:chatui/Widgets/small_text.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const BigText(text: "Perfil"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const SmallText(text: "Ayuda y Comentarios",fw: FontWeight.bold,),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    ItemListConf(title: "Centro ayuda", icon: Icons.edit_document),
                    ItemListConf(title: "Comentarios", icon: Icons.message),
                    ItemListConf(title: "Calificanos", icon: Icons.library_add_check_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              const SmallText(text: "Configuracion",fw: FontWeight.bold,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ItemListConf(title: "Centro ayuda", icon: Icons.edit_document),
                    ItemListConf(title: "Comentarios", icon: Icons.message),
                    ItemListConf(title: "Calificanos", icon: Icons.library_add_check_rounded),
                    GestureDetector(
                      onTap: () {},
                      child: ItemListConf(title: "Cerrar Sesion", icon: Icons.exit_to_app),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
    );
  }
}