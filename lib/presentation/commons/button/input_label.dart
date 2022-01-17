import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/const.dart';
import 'package:miapp/config/style.dart';

class InputLabel extends StatefulWidget {
  final String hintText;
  final bool phone;
  final bool phoneFlag;
  final Function(String)? onChanged;
  final Color colorlabel;

  final bool enabled;

  final Color colorText;

  final Color? colorPlaceHolder;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType keyboardType;
  const InputLabel(
      {Key? key,
      required this.hintText,
      required this.phone,
      this.phoneFlag = false,
      this.onChanged,
      this.enabled = true,
      this.colorPlaceHolder,
      this.keyboardType = TextInputType.streetAddress,
      this.controller,
      this.colorlabel = AppColors.mainSecondary,
      this.colorText = Colors.white,
      this.errorText})
      : super(key: key);

  @override
  State<InputLabel> createState() => _InputLabelState();
}

class _InputLabelState extends State<InputLabel> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  String? _getErrorFocus() {
    return _focusNode.hasFocus ? null : widget.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: (widget.phone || widget.phoneFlag)
          ? TextInputType.number
          : widget.keyboardType,
      inputFormatters: <TextInputFormatter>[
        if (widget.phone) ...[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ],
        if (widget.phoneFlag) ...[
          FilteringTextInputFormatter.allow(RegExp(r'[1-9][0-9]*'))
        ]
      ],
      enabled: widget.enabled,
      style: placeHolderStyle.copyWith(color: widget.colorText),
      autocorrect: true,
      autofocus: false,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppConstants.borderButton)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent, width: 1, style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent, width: 1, style: BorderStyle.solid),
          ),
          fillColor: widget.colorlabel,
          filled: true,
          errorText: _getErrorFocus(),
          errorStyle: const TextStyle(
            color: AppColors.redSecondary,
          ),
          errorMaxLines: 1,
          contentPadding: EdgeInsets.only(
            top: widget.phoneFlag ? 10 : 2,
            left: 10,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.redSecondary,
                width: 1,
                style: BorderStyle.solid),
          ),
          focusedErrorBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: placeHolderStyle.copyWith(color: widget.colorPlaceHolder)),
    );
  }
}
