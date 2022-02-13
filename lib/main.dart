import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miapp/presentation/home/home.dart';
import 'package:miapp/presentation/login/login.dart';

import 'app_main.dart';

var userMail = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var user = _firebaseAuth.currentUser;
  bool isHome = false;
  if (user != null) {
    isHome = true;
    print('tengo sesion activa');
    userMail = user.email!;
  }
  runApp(ProviderScope(
      child: App(
    title: "Flutter Riverpod",
    initRoute: isHome ? HomePage.namePage : LoginPage.namePage,
  )));
}
