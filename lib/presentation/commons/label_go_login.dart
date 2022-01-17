import 'package:flutter/material.dart';
import 'package:miapp/config/style.dart';
import '../../../config/colors.dart';

class LabelGoPage extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelPrincipal;
  final String labelIr;
  final Color colorLabelPrincipal;
  final Color colorLabelIr;

  const LabelGoPage(
      {required this.onPressed,
      required this.labelPrincipal,
      required this.labelIr,
      this.colorLabelPrincipal = AppColors.textoGeneral,
      this.colorLabelIr = AppColors.mainColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          labelPrincipal,
          overflow: TextOverflow.fade,
          style: subtituloStyle.copyWith(color: colorLabelPrincipal),
        ),
        const SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: onPressed,
          child: Text(
            labelIr,
            overflow: TextOverflow.fade,
            style: subtituloStyle.copyWith(color: colorLabelIr),
          ),
        )
      ],
    );
  }
}
