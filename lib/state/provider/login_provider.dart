import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miapp/core/utils/dialogs.dart';
import 'package:miapp/main.dart';
import 'package:miapp/presentation/home/home.dart';

class LoginProvider extends ChangeNotifier {
  late BuildContext contextLogin;
  late ProgressDialog dialog;
  String correo = '';
  String contrasenia = '';

  //login con firebaseauth
  Future<void> getLogin({String email = '', String password = ''}) async {
    dialog = ProgressDialog(
      contextLogin,
    );
    dialog.show();
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('Hice login');
        dialog.dismiss();
        userMail = email;
        HomePage.goHomePage(contextLogin);
      } on FirebaseAuthException catch (e) {
        String error = 'Error al iniciar sesión';
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          error = 'No existe un usuario con ese correo';
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided.');
          error = 'Contraseña incorrecta';
        }
        dialog.dismiss();
        Snack.showInSnackBar(contextLogin, error);
      }
      notifyListeners();
    } catch (e) {
      dialog.dismiss();
      Snack.showInSnackBar(contextLogin, e.toString());
      notifyListeners();
    }
  }
}
