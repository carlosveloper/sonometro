import 'package:flutter/material.dart';
import 'package:miapp/presentation/home/home.dart';
import 'package:miapp/presentation/login/login.dart';
import 'package:miapp/presentation/register/registro.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // print('ruta --->');
    // print(settings.name);
    var ruta = settings.name ?? '';
    switch (ruta) {
      case LoginPage.namePage:
        return MaterialPageRoute(
            builder: (_) => LoginPage(), settings: settings);

      case HomePage.namePage:
        return MaterialPageRoute(
            builder: (_) => const HomePage(), settings: settings);

      case RegistroPage.namePage:
        return MaterialPageRoute(
            builder: (_) => RegistroPage(), settings: settings);

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute(settings: settings, name: ruta);
    }
  }

  static Route<dynamic> _errorRoute({settings, required String name}) {
    return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text('Pagina No Encontrada Posiblemente '
                      'este en Desarrollo' +
                  name),
            ),
          );
        },
        settings: settings);
  }
}
