import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String namePage = '/Home';

  static void goHomePage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(namePage, (route) => false, arguments: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('HomePage')),
    );
  }
}
