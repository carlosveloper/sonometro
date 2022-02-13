import 'package:flutter/material.dart';
import 'package:miapp/presentation/profile/profile.dart';
import 'package:miapp/presentation/sonometro/sonometro.dart';

class HomeProvider extends ChangeNotifier {
  int pagePresent = 0;
  bool _mounted = true;
  bool get mounted => _mounted;

  List<String> listNamePage = ['Home', 'Historial Búsqueda', 'Perfil'];

  List<Widget> listPage = [SonoMetroPage(), MenuProfile()];

  void _setState() {
    if (!mounted) return;
    notifyListeners();
  }

  void changeSelect(int selectPage) {
    pagePresent = selectPage;
    validPersistenPage();
    _setState();
  }

  void validPersistenPage() {
    // if it hasn't, then it still is a SizedBox
    /* if (listPage[pagePresent] is SizedBox) {
      if (pagePresent == 1) {
        listPage[pagePresent] = const MenuProfile();
      }
    } */

    /*   if (index == 0) {

      setState(() {

        screens.removeAt(0);

        screens.insert(0, new HomePage(key: UniqueKey()));

        tabIndex = index;
      });
    } */
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
