/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pydenos/config/colors.dart';
import 'package:pydenos/config/const.dart';
import 'package:pydenos/config/style.dart';
import 'package:provider/provider.dart';
import 'package:pydenos/presentation/common/button_send.dart';
import 'package:pydenos/presentation/common/input_label_stream.dart';
import 'package:pydenos/presentation/common/input_password_stream.dart';
import 'package:pydenos/presentation/register/widget/label_go_login.dart';
import 'package:pydenos/state/provider/forget_password.dart';

class ForgetPasswordPasswordPage extends StatelessWidget {
  ForgetPasswordPasswordPage._();
  static ChangeNotifierProvider init() =>
      ChangeNotifierProvider<ForgetPasswordProvider>(
        create: (_) => ForgetPasswordProvider(),
        builder: (_, __) => ForgetPasswordPasswordPage._(),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var forgetApp = Provider.of<ForgetPasswordProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: AppConstants.heightLogo,
                child: Hero(
                  tag: 'logoHero',
                  child: SvgPicture.asset(
                    'assets/images/pydenos_blue.svg',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Recuperar contraseña',
                style: superTitulo2Style.copyWith(color: AppColors.mainColor),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                forgetApp.titulos[forgetApp.step],
                style: nombreUsuarioStyle,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              formValidate(forgetApp.step, forgetApp, size),
              SizedBox(
                height: size.height * 0.02,
              ),
              buttons(forgetApp, context),
              SizedBox(
                height: size.height * 0.03,
              ),
              Align(child: goLogin(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputEmail(ForgetPasswordProvider forgetApp) {
    return InputLabelStream(
      hintText: 'Correo',
      onChanged: forgetApp.loginBloc.changeEmail,
      stream: forgetApp.loginBloc.emailStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
    );
  }

  Widget inputPin(ForgetPasswordProvider forgetApp) {
    return InputLabelStream(
      hintText: 'Pin',
      onChanged: forgetApp.registerbloc.changePin,
      stream: forgetApp.registerbloc.pinStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
      phone: true,
    );
  }

  Widget goLogin(context) {
    return LabelGoLogin(
      labelPrincipal: 'Ya tienes una cuenta',
      labelIr: 'Iniciar Sesíon',
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Login', (route) => false);
      },
    );
  }

  Widget password(ForgetPasswordProvider forgetApp) {
    return InputPasswordStream(
      hintText: 'Contraseña',
      onChanged: forgetApp.registerbloc.changePassword,
      stream: forgetApp.registerbloc.passwordStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
      colorIconEye: AppColors.textoGeneral,
    );
  }

  Widget rePassword(ForgetPasswordProvider forgetApp) {
    return InputPasswordStream(
      hintText: 'Repetir Contraseña',
      onChanged: forgetApp.registerbloc.changeRePassword,
      stream: forgetApp.registerbloc.repasswordStream,
      colorlabel: AppColors.backgroundAzulCajaTexto,
      colorText: AppColors.textoGeneral,
      colorPlaceHolder: AppColors.placeholderSecondary,
      activateValidation: true,
      colorIconEye: AppColors.textoGeneral,
    );
  }

  Widget buttonSend(
      Stream? stream, ForgetPasswordProvider forgetApp, BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return ButtonSend(
            colorButton: (!snapshot.hasError && snapshot.hasData)
                ? AppColors.accentColor
                : AppColors.amarilloPalido,
            onPressed: () async {
              if (!snapshot.hasError && snapshot.hasData) {
                forgetApp.send(context);
              }
            },
            textLabel: forgetApp.buttonLabel[forgetApp.step],
          );
        });
  }

  Widget formValidate(int valor, ForgetPasswordProvider forgetApp, Size size) {
    switch (valor) {
      case 0:
        return inputEmail(forgetApp);
      case 1:
        return Center(child: inputPin(forgetApp));
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            password(forgetApp),
            SizedBox(
              height: size.height * 0.02,
            ),
            rePassword(forgetApp)
          ],
        );
    }

    return Container();
  }

  Widget buttons(ForgetPasswordProvider forgetApp, BuildContext context) {
    switch (forgetApp.step) {
      case 0:
        return buttonSend(
            forgetApp.loginBloc.formValidCambio, forgetApp, context);
      case 1:
        return Center(
            child: buttonSend(
                forgetApp.registerbloc.pinStream, forgetApp, context));
      case 2:
        return Align(
            child: buttonSend(forgetApp.registerbloc.formValidPasswordStream,
                forgetApp, context));
    }
    return Container();
  }
}
 */