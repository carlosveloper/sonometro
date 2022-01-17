import 'package:flutter/material.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/core/utils/extensions.dart';
import 'input_label.dart';

class InputLabelStream extends StatelessWidget {
  final Stream<dynamic> stream;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool phone;
  final bool activateValidation;
  final bool phoneFlag;
  final Color colorlabel;
  final Color? colorPlaceHolder;
  final Color colorText;
  final TextEditingController? controller;
  final bool enabled;
  final TextInputType keyboardType;

  const InputLabelStream({
    required this.stream,
    required this.onChanged,
    required this.hintText,
    this.controller,
    this.colorPlaceHolder,
    this.phone = false,
    this.phoneFlag = false,
    this.keyboardType = TextInputType.streetAddress,
    this.enabled = true,
    this.colorlabel = AppColors.mainSecondary,
    this.colorText = Colors.white,
    Key? key,
    this.activateValidation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        return InputLabel(
            hintText: hintText,
            onChanged: onChanged,
            controller: controller,
            colorPlaceHolder: colorPlaceHolder,
            colorlabel: colorlabel,
            colorText: colorText,
            phone: phone,
            phoneFlag: phoneFlag,
            enabled: enabled,
            keyboardType: keyboardType,
            errorText:
                !activateValidation ? null : snapshot.getStringError(snapshot));
      },
    );
  }
}
