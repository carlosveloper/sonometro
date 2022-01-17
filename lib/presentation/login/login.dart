import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/const.dart';
import 'package:miapp/config/style.dart';
import 'package:miapp/core/utils/dialogs.dart';
import 'package:miapp/core/utils/extensions.dart';
import 'package:miapp/presentation/commons/button/button_send.dart';
import 'package:miapp/presentation/commons/button/input_label.dart';
import 'package:miapp/presentation/commons/button/input_password.dart';
import 'package:miapp/presentation/commons/label_go_login.dart';
import 'package:miapp/presentation/register/registro.dart';
import 'package:miapp/state/provider/login_provider.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final loginChangeNotifierProvider =
      ChangeNotifierProvider.autoDispose<LoginProvider>((ref) {
    return LoginProvider();
  });

  static const String namePage = '/Login';

  static void goLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(namePage, (route) => false, arguments: '');
  }

  @override
  Widget build(context, ref) {
    final loginProvider = ref.watch(loginChangeNotifierProvider);
    loginProvider.contextLogin = context;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Hero(
                        tag: 'logoHero',
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    inputEmail(loginProvider),
                    SizedBox(height: size.height * 0.02),
                    password(loginProvider),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(height: size.height * 0.015),
                    buttonRequest(context, loginProvider),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              Positioned(
                bottom: size.height * 0.1,
                child: goRegister(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputEmail(LoginProvider loginProvider) {
    return InputLabel(
      key: const ValueKey('Correo'),
      hintText: 'Correo',
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) {
        loginProvider.correo = email;
      },
      phone: false,
    );
  }

  Widget password(LoginProvider loginProvider) {
    return InputPassword(
      key: const ValueKey('Contraseña'),
      hintText: 'Contraseña',
      onChanged: (password) {
        loginProvider.contrasenia = password;
      },
    );
  }

  Widget buttonRequest(BuildContext context, LoginProvider loginProvider) {
    return ButtonSend(
      key: const ValueKey('SendLogin'),
      colorButton: AppColors.accentColor,
      onPressed: () {
        if (loginProvider.correo.trim().isEmpty &&
            loginProvider.contrasenia.trim().isEmpty) {
          Snack.showInSnackBar(context, 'Los campos son requeridos');
          return;
        }

        if (loginProvider.contrasenia.trim().isEmpty) {
          Snack.showInSnackBar(context, 'La email es requerido');
          return;
        }

        if (!loginProvider.correo.validateCorreo) {
          Snack.showInSnackBar(context, 'El email es incorrecto');
          return;
        }

        if (loginProvider.contrasenia.trim().isEmpty) {
          Snack.showInSnackBar(context, 'La contraseña es requerida');
          return;
        }
        FocusScope.of(context).requestFocus(FocusNode());

        loginProvider.getLogin(
          email: loginProvider.correo,
          password: loginProvider.contrasenia,
        );
      },
      textLabel: 'Ingresar',
    );
  }

  Widget goRegister(BuildContext context) {
    return LabelGoPage(
      key: const ValueKey('GoRegister'),
      labelPrincipal: 'Aún no tienes una cuenta |',
      labelIr: 'Regístrate',
      colorLabelPrincipal: Colors.white,
      colorLabelIr: AppColors.secondColor,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        RegistroPage.goRegistroPage(context);
      },
    );
  }
}
