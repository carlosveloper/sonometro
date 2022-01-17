import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/core/utils/dialogs.dart';
import 'package:miapp/core/utils/extensions.dart';
import 'package:miapp/presentation/commons/button/button_send.dart';
import 'package:miapp/presentation/commons/button/input_button_stream.dart';
import 'package:miapp/presentation/commons/button/input_label.dart';
import 'package:miapp/presentation/commons/button/input_label_stream.dart';
import 'package:miapp/presentation/commons/button/input_password.dart';
import 'package:miapp/presentation/commons/button/input_password_stream.dart';
import 'package:miapp/presentation/commons/button/spacing_vertical.dart';
import 'package:miapp/presentation/commons/label_go_login.dart';
import 'package:miapp/presentation/login/login.dart';
import 'package:miapp/state/provider/login_provider.dart';
import 'package:miapp/state/provider/registro_provider.dart';

class RegistroPage extends ConsumerWidget {
  RegistroPage({Key? key}) : super(key: key);

  final registroChangeNotifierProvider =
      ChangeNotifierProvider.autoDispose<RegistroProvider>((ref) {
    return RegistroProvider();
  });

  static const String namePage = '/Registro';

  static void goRegistroPage(BuildContext context) {
    Navigator.of(context).pushNamed(
      namePage,
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, watch, child) {
          var registerProvider = ref.watch(registroChangeNotifierProvider);
          registerProvider.contextRegistro = context;

          return SizedBox(
            height: size.height,
            child: Container(
              height: size.height,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06, vertical: 10),
              child: ListView(
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
                  SizedBox(height: size.height * 0.02),
                  inputName(registerProvider),
                  SpacingVerticalStream(
                      stream: registerProvider.blocRegister.nombresStream),
                  inputEmail(registerProvider),
                  SpacingVerticalStream(
                      stream: registerProvider.blocRegister.emailStream),
                  password(registerProvider),
                  SpacingVerticalStream(
                      stream: registerProvider.blocRegister.passwordStream),
                  rePassword(registerProvider),
                  SpacingVerticalStream(
                      stream: registerProvider.blocRegister.repasswordStream),
                  buttonRequest(context, registerProvider),
                  SizedBox(height: size.height * 0.02),
                  Center(child: goLogin(context))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget inputName(RegistroProvider registerProvider) {
    return InputLabelStream(
      hintText: 'Nombres',
      onChanged: registerProvider.blocRegister.changeNombres,
      stream: registerProvider.blocRegister.nombresStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
    );
  }

  Widget inputLastName(RegistroProvider registerProvider) {
    return InputLabelStream(
      hintText: 'Apellidos',
      onChanged: registerProvider.blocRegister.changeApellidos,
      stream: registerProvider.blocRegister.apellidosStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
    );
  }

  Widget inputEmail(RegistroProvider registerProvider) {
    return InputLabelStream(
      hintText: 'Correo',
      onChanged: registerProvider.blocRegister.changeEmail,
      stream: registerProvider.blocRegister.emailStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      keyboardType: TextInputType.emailAddress,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
    );
  }

  Widget password(RegistroProvider registerProvider) {
    return InputPasswordStream(
      hintText: 'Contraseña',
      onChanged: registerProvider.blocRegister.changePassword,
      stream: registerProvider.blocRegister.passwordStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
      colorIconEye: AppColors.textoGeneral,
    );
  }

  Widget rePassword(RegistroProvider registerProvider) {
    return InputPasswordStream(
      hintText: 'Repetir Contraseña',
      onChanged: registerProvider.blocRegister.changeRePassword,
      stream: registerProvider.blocRegister.repasswordStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
      colorIconEye: AppColors.textoGeneral,
    );
  }

  Widget buttonRequest(context, RegistroProvider registerProvider) {
    return InputButtonStream(
      textLabel: 'Registrarme',
      onPressed: (snapshot) async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        if (snapshot.hasData) {
          registerProvider.registroAuthFirebase();
        } else {
          Snack.showInSnackBar(context, 'Todos los campos son requeridos');
        }
      },
      stream: registerProvider.blocRegister.formValidStream,
    );
  }

  Widget goLogin(context) {
    return LabelGoPage(
      labelPrincipal: 'Ya tienes una cuenta',
      labelIr: 'Iniciar Sesíon',
      onPressed: () {
        LoginPage.goLoginPage(context);
      },
    );
  }
}
