import 'package:flutter/material.dart';
import 'package:miapp/config/colors.dart';

import 'button_send.dart';

class InputButtonStream extends StatelessWidget {
  final Stream<dynamic> stream;
  final ValueChanged<AsyncSnapshot> onPressed;
  final String textLabel;

  final Color colorButton;
  final Color colorLabelText;

  const InputButtonStream(
      {required this.stream,
      required this.onPressed,
      required this.textLabel,
      this.colorButton = AppColors.secondColor,
      this.colorLabelText = AppColors.textoGeneral,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        return ButtonSend(
          colorButton: colorButton,
          colorLabelText: colorLabelText,
          onPressed: () {
            onPressed(snapshot);
          },
          textLabel: textLabel,
        );
      },
    );
  }
}
