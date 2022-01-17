import 'package:flutter/material.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/core/utils/extensions.dart';

import 'input_password.dart';

class InputPasswordStream extends StatelessWidget {
  final Stream<dynamic> stream;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool activateValidation;

  final Color colorlabel;

  final Color colorText;

  final Color? colorPlaceHolder;

  final Color colorIconEye;

  const InputPasswordStream(
      {required this.stream,
      required this.onChanged,
      required this.hintText,
      this.colorPlaceHolder,
      this.colorlabel = AppColors.mainSecondary,
      this.colorText = Colors.white,
      this.colorIconEye = Colors.white,
      Key? key,
      this.activateValidation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        return InputPassword(
            hintText: hintText,
            colorPlaceHolder: colorPlaceHolder,
            colorText: colorText,
            colorlabel: colorlabel,
            onChanged: onChanged,
            colorIconEye: colorIconEye,
            errorText:
                !activateValidation ? null : snapshot.getStringError(snapshot));
      },
    );
  }
}
