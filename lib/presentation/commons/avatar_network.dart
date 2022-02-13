import 'dart:io';

import 'package:flutter/material.dart';
import '../../config/colors.dart';

class MyAvatarNetWork extends StatefulWidget {
  final double size;
  final String url;
  final String tagHero;
  final String assetImageError;
  final double borderRadius;
  final bool borderLigth;
  final File? fileImage;
  final bool isFile;
  final bool isPreview;

  const MyAvatarNetWork({
    required this.size,
    required this.url,
    Key? key,
    required this.assetImageError,
    this.borderRadius = 2,
    this.borderLigth = true,
    this.isFile = false,
    this.fileImage,
    this.isPreview = true,
    required this.tagHero,
  }) : super(key: key);

  @override
  _MyAvatarNetWorkState createState() => _MyAvatarNetWorkState();
}

class _MyAvatarNetWorkState extends State<MyAvatarNetWork> {
  bool _isError = false;
  double limite = -3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isPreview ? () {} : null,
      child: Hero(
        tag: widget.tagHero,
        child: CircleAvatar(
          radius: widget.size + limite,
          backgroundColor: miColorBorder(),
          child: CircleAvatar(
            radius: widget.size - widget.borderRadius + limite,
            backgroundImage: imagePresent(),
            backgroundColor: Colors.white,
            onBackgroundImageError: (_, e) {
              if (mounted) {
                setState(() {
                  _isError = true;
                });
              }
            },
            child: _isError ? avatarAssets() : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget avatarAssets() {
    _isError = false;

    return CircleAvatar(
      backgroundColor: miColorBorder(),
      radius: widget.size,
      child: CircleAvatar(
        radius: widget.size - widget.borderRadius,
        backgroundImage: AssetImage(
          widget.assetImageError,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Color miColorBorder() {
    return widget.borderLigth
        ? AppColors.accentColor
        : AppColors.mensajeHoraIcono;
  }

  ImageProvider imagePresent() {
    if (widget.isFile) {
      return FileImage(widget.fileImage!);
    }

    return NetworkImage(widget.url);
  }
}
