import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/style.dart';
import 'package:miapp/presentation/home/widget/tab_bar.dart';
import 'package:miapp/state/provider/home_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

var homeChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return HomeProvider();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String namePage = '/Home';

  static void goHomePage(BuildContext context) {
    homeChangeNotifierProvider = ChangeNotifierProvider((ref) {
      return HomeProvider();
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil(namePage, (route) => false, arguments: '');
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomeProvider appHome;
  @override
  Widget build(BuildContext context) {
    appHome = ref.watch(homeChangeNotifierProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
          title: Text(
            appHome.listNamePage[appHome.pagePresent],
            style: tituloStyle.copyWith(color: Colors.white),
          ),
        ),
        body: appHome.listPage[appHome.pagePresent],
        bottomNavigationBar: const TabBarHome(),
      ),
    );
  }
}
