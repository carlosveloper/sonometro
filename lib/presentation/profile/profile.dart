import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:miapp/config/colors.dart';
import 'package:miapp/config/const.dart';
import 'package:miapp/config/style.dart';
import 'package:miapp/main.dart';
import 'package:miapp/presentation/commons/avatar_network.dart';
import 'package:miapp/presentation/login/login.dart';

class MenuProfile extends StatefulWidget {
  const MenuProfile({Key? key}) : super(key: key);

  static const String namePage = '/MenuProfile';

  static void goLoginPage(BuildContext context) {
    Navigator.of(context).pushNamed(namePage);
  }

  @override
  State<MenuProfile> createState() => _MenuProfileState();
}

class _MenuProfileState extends State<MenuProfile> {
  var user = '';

  @override
  void initState() {
    super.initState();

    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(userMail)
        .get();

    var x = querySnapshot.data() as Map<String, dynamic>;
    user = x['nombres'];
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var spacio = 0.02;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAvatarNetWork(
            tagHero: 'profile-' + UniqueKey().toString(),
            size: 90,
            borderRadius: 1.5,
            url:
                'https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236_1280.png',
            borderLigth: true,
            assetImageError: AppConstants.imagePlaceHolder,
          ),
          SizedBox(
            height: size.height * spacio,
          ),
          Text(
            user,
            style: usuarioPerfilStyle,
          ),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              LoginPage.goLoginPage(context);
            },
            child: Text('Cerrar Sesión',
                style:
                    subtituloStyle.copyWith(color: AppColors.textoGeneralGris)),
          ),
        ],
      ),
    ));
  }

  String nombres(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    if (snapshot.hasData) {
      var user = snapshot.data!.data();
      return 'prueba';
    }

    return '';
  }

  Widget itemMenu(String image, String title, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20, width: 20, child: Icon(Icons.logout)),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: subtituloStyle,
            )
          ],
        ),
      ),
    );
  }
}

class UserCheck {
  final String nombres;
  UserCheck({
    required this.nombres,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombres': nombres,
    };
  }

  factory UserCheck.fromMap(Map<String, dynamic> map) {
    return UserCheck(
      nombres: map['nombres'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCheck.fromJson(String source) =>
      UserCheck.fromMap(json.decode(source));
}
