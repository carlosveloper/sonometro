import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/config/style.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //   Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  //color: AppColors().mainColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                ),
                accountName: Text(
                  'caros',
                  style: Theme.of(context).textTheme.headline6,
                ),
                accountEmail: Text(
                  'correo',
                  style: Theme.of(context).textTheme.caption,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  /* backgroundImage: NetworkImage( */
                  /*     "https://www.elsoldemexico.com.mx/finanzas/nhqk9l-steve-jobs-apple/ALTERNATES/LANDSCAPE_1140/Steve%20Jobs%20Apple",), */
                  child: ClipRRect(
                    // borderRadius: new BorderRadius.circular(100.0),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQqXJSJ-I3aOx25n541u1AqXN1VlOILtJ76Dg&usqp=CAU',
                      fit: BoxFit.fill,
                    ),
                  ),
                )
                /* CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                /* backgroundImage: NetworkImage( */
                /*     "https://www.elsoldemexico.com.mx/finanzas/nhqk9l-steve-jobs-apple/ALTERNATES/LANDSCAPE_1140/Steve%20Jobs%20Apple",), */
                child: ClipRRect(
                  // borderRadius: new BorderRadius.circular(100.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQqXJSJ-I3aOx25n541u1AqXN1VlOILtJ76Dg&usqp=CAU',
                    fit: BoxFit.fill,
                  ),
                ),
              ), */
                ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Menú",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.ac_unit,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              FontAwesomeIcons.userAlt,
              color: AppColors.textoGeneralGris,
            ),
            title: Text(
              "Persona",
              style: mensajeActivoStyle,
            ),
            /*  trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '10',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ), */
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/RegistroMedico');
            },
            leading: Icon(
              Icons.directions_run,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Registro Medicos",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/CardTags', arguments: 2);
            },
            leading: Icon(
              Icons.local_hospital,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Mis Tarjetas",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/RecargaTags', arguments: 2);
            },
            leading: Icon(
              Icons.credit_card,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Planes y Recargas",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Historial', arguments: 2);
            },
            leading: Icon(
              Icons.zoom_in,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Historial",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Users', arguments: 0);
            },
            leading: Icon(
              Icons.supervised_user_circle_sharp,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Usuarios",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Ingresos', arguments: 0);
            },
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Ingresos Hoy",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Notificacion', arguments: 0);
            },
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notificaciones Plan",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            /* trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '10',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ), */
          ),
          ListTile(
            dense: true,
            title: Text(
              "Preferencias de Aplicación",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.notifications,
              //color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          /* ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Help');
            },
            leading: Icon(
              UiIcons.settings_2,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Ayuda y Soporte",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ), */
          /*  ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Configuraciones",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ), */
          ListTile(
            onTap: () async {
              /*    final provider = context.read<UserProvider>();
              provider.signOut(); */

              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/Login",
                  (
                    Route<dynamic> route,
                  ) =>
                      false);

              // final varContext = context.watch()<UserProvider>();
              //signOut
              //   varContext.signOut();
              //Navigator.of(context).pushNamed('/Login');
              print('debo salir de sesion');
            },
            leading: Icon(
              Icons.close,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Cerrar Sesión",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
