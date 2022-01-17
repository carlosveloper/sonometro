import 'package:flutter/material.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/const.dart';
import 'package:miapp/config/style.dart';

class ButtonSend extends StatelessWidget {
  final Function()? onPressed;

  final String textLabel;
  final Color colorButton;
  final Color colorLabelText;

  const ButtonSend({
    Key? key,
    required this.onPressed,
    required this.textLabel,
    this.colorButton = AppColors.secondColor,
    this.colorLabelText = AppColors.textoGeneral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.heightButton,
      margin: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderButton),
          ),
          primary: colorButton,
        ),
        child: Text(
          textLabel,
          textAlign: TextAlign.center,
          style: subtituloStyle.copyWith(color: colorLabelText),
        ),
      ),
    );
  }
}
