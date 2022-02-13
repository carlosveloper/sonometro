import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/presentation/home/home.dart';

class TabBarHome extends ConsumerStatefulWidget {
  const TabBarHome({Key? key}) : super(key: key);

  @override
  _TabBarHomeState createState() => _TabBarHomeState();
}

class _TabBarHomeState extends ConsumerState<TabBarHome> {
  double sizeIcons = 26.0;

  @override
  Widget build(BuildContext context) {
    var _homeProvider = ref.read(homeChangeNotifierProvider);

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: AppColors.mensajeHoraIcono, width: 0.5))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 10,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.mainColor,
        selectedIconTheme:
            const IconThemeData(color: AppColors.mainColor, size: 20),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: _homeProvider.pagePresent,
        onTap: (int selectPage) {
          _homeProvider.changeSelect(selectPage);
        },
        items: [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(
              Icons.home,
              size: sizeIcons,
            ),
          ),
          BottomNavigationBarItem(
            label: "Perfil",
            icon: Icon(
              Icons.person,
              size: sizeIcons,
            ),
          ),
        ],
      ),
    );
  }
}
