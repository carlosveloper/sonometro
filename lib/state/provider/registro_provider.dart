import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miapp/core/utils/dialogs.dart';
import 'package:miapp/main.dart';
import 'package:miapp/model/user.dart';
import 'package:miapp/presentation/home/home.dart';
import 'package:miapp/state/bloc/register_user_bloc.dart';

class RegistroProvider extends ChangeNotifier {
  late BuildContext contextRegistro;
  late ProgressDialog dialog;

  RegisterUseBloc blocRegister = RegisterUseBloc();

  Future<void> registroAuthFirebase() async {
    dialog = ProgressDialog(
      contextRegistro,
    );
    dialog.show();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: blocRegister.email!, password: blocRegister.password!);

      FirebaseFirestore.instance
          .collection("usuarios")
          .doc(blocRegister.email!)
          .set(Usuario(
                  email: blocRegister.email!, nombres: blocRegister.nombres!)
              .toMap())
          .then((_) {
        print("registrado!");
      });

      dialog.dismiss();
      userMail = blocRegister.email!;

      HomePage.goHomePage(contextRegistro);
    } on FirebaseAuthException catch (error) {
      dialog.dismiss();
      Snack.showInSnackBar(contextRegistro, error.code);
    } catch (error) {
      dialog.dismiss();
      Snack.showInSnackBar(contextRegistro, error.toString());
    }
  }
}
