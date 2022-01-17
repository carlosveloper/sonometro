import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Dialogs {
  static void alert(BuildContext context,
      {String? title, String? description}) {
    showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: description != null ? Text(description) : null,
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              )
            ],
          );
        });
  }
}

class ProgressDialog {
  final BuildContext context;
  ProgressDialog(this.context);

  void show() {
    showCupertinoModalPopup(
      context: context,
      routeSettings: const RouteSettings(name: 'Loading'),
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.7),
          child: const CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ),
    );
  }

  void dismiss() {
    Navigator.pop(context);
  }
}

class Snack {
  static void showInSnackBar(context, mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensaje),
      duration: const Duration(seconds: 3),
      /* action: SnackBarAction(
        label: '',
        onPressed: () {},
      ), */
    ));
  }
}

class Toast {
  static void showToast(mensaje, {int seconds = 6}) {
    showToastWidget(
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(mensaje)),
        duration: Duration(seconds: seconds),
        position: ToastPosition.bottom);
  }
}
