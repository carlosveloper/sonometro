import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/colors.dart';
import 'config/route_generator.dart';

class App extends StatelessWidget {
  final String title;
  final String initRoute;
  const App({Key? key, required this.title, this.initRoute = '/'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: initRoute,
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            primaryColor: AppColors.mainColor,
            brightness: Brightness.light,
            focusColor: AppColors.textoGeneral,
            hintColor: AppColors.placeholderSecondary,
            textTheme: TextTheme(
              button: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white),
              ),

              //Title
              headline6: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainColor)),
              headline5: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainSecondary),
              ),
              headline4: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainSecondary)),
              headline3: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainSecondary)),
              headline2: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AppColors.mainColor)),

              headline1: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: AppColors.mainSecondary)),

              ///lo que se escribe dentro del TextField

              subtitle1: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: AppColors.mainSecondary)),

              subtitle2: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainSecondary)),

              bodyText1: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainSecondary)),
              bodyText2: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainSecondary)),
            ),
          )),
    );
  }
}
