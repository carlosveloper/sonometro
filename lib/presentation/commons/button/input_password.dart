import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/const.dart';
import 'package:miapp/config/style.dart';

class InputPassword extends StatefulWidget {
  final Function(String)? onChanged;
  final String hintText;
  final String? errorText;

  final Color colorlabel;

  final Color colorText;

  final Color? colorPlaceHolder;

  final Color colorIconEye;

  const InputPassword({
    required this.onChanged,
    required this.hintText,
    this.colorPlaceHolder,
    this.colorlabel = AppColors.mainSecondary,
    this.colorText = Colors.white,
    this.colorIconEye = Colors.white,
    Key? key,
    this.errorText,
  }) : super(key: key);

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscuredText = true;
  void toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

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
      obscureText: _obscuredText,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      style: placeHolderStyle.copyWith(color: widget.colorText),
      decoration: InputDecoration(
          fillColor: widget.colorlabel,
          filled: true,
          errorText: _getErrorFocus(),
          errorStyle: const TextStyle(color: AppColors.redSecondary),
          contentPadding: const EdgeInsets.only(top: 10, left: 10),
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
          focusedErrorBorder: InputBorder.none,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.redSecondary,
                width: 1,
                style: BorderStyle.solid),
          ),
          hintText: widget.hintText,
          suffixIcon: GestureDetector(
            onTap: toggle,
            child: Icon(
                _obscuredText
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                size: 20,
                color: _obscuredText
                    ? widget.colorIconEye.withOpacity(0.7)
                    : widget.colorIconEye),
          ),
          hintStyle: placeHolderStyle.copyWith(color: widget.colorPlaceHolder)),
    );
  }
}
