import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  // static Brightness getIconBrightness(
  //     BuildContext context, ThemeOptionType optionType) {
  //   if (optionType == ThemeOptionType.SYSTEM) {
  //     final brightness = WidgetsBinding.instance.window.platformBrightness;
  //     return brightness == Brightness.light
  //         ? Brightness.dark
  //         : Brightness.light;
  //   }

  //   return optionType == ThemeOptionType.LIGHT
  //       ? Brightness.dark
  //       : Brightness.light;
  // }

  // static ThemeMode getThemeMode(ThemeOptionType optionType) {
  //   return optionType == ThemeOptionType.LIGHT
  //       ? ThemeMode.light
  //       : optionType == ThemeOptionType.DARK
  //           ? ThemeMode.dark
  //           : ThemeMode.system;
  // }

  static ThemeData get lightTheme => ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
        primaryColor: CupertinoColors.systemBlue,
        primaryColorLight: CupertinoColors.systemBlue.darkHighContrastColor,
        primaryColorDark: CupertinoColors.systemBlue.darkColor,
        primaryColorBrightness: Brightness.light,
        primaryIconTheme: IconThemeData(color: CupertinoColors.white),
        accentColor: const Color(0xFF2196F3),
        accentColorBrightness: Brightness.light,
        accentIconTheme: IconThemeData(color: const Color(0xFFFFFFFF)),
        textTheme: getTextTheme(const Color(0xFF000000)),
        primaryTextTheme: getTextTheme(CupertinoColors.white),
        accentTextTheme: getTextTheme(const Color(0xFFFFFFFF)),
        scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: CupertinoColors.activeBlue.withOpacity(0.9),
          iconTheme: IconThemeData(color: CupertinoColors.white),
          actionsIconTheme: IconThemeData(color: CupertinoColors.white),
          textTheme: getTextTheme(CupertinoColors.white),
        ),
        buttonTheme: ButtonThemeData(
          height: 48.0,
          colorScheme: ColorScheme.light(),
          textTheme: ButtonTextTheme.primary,
          buttonColor: Colors.blue,
          disabledColor: const Color(0xFFBBDDFB),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: const Color(0xFF2196F3),
          hoverColor: const Color(0xFF2196F3),
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
        accentColor: const Color(0xFF2196F3),
        accentColorBrightness: Brightness.dark,
        accentIconTheme: IconThemeData(color: const Color(0xFFFFFFFF)),
        textTheme: getTextTheme(const Color(0xFFFFFFFF)),
        primaryTextTheme: getTextTheme(const Color(0xFFFFFFFF)),
        accentTextTheme: getTextTheme(const Color(0xFFF0F0F0)),
        appBarTheme: AppBarTheme(
          textTheme: getTextTheme(const Color(0xFFFFFFFF)),
        ),
        buttonTheme: ButtonThemeData(
          height: 48.0,
          textTheme: ButtonTextTheme.primary,
          buttonColor: const Color(0xFF2196F3),
          disabledColor: const Color(0xFFBBDDFB),
        ),
      );

  static TextTheme getTextTheme(Color color) {
    return TextTheme(
      headline1: GoogleFonts.raleway(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: color,
      ),
      headline2: GoogleFonts.raleway(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: color,
      ),
      headline3: GoogleFonts.raleway(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headline4: GoogleFonts.raleway(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      ),
      headline5: GoogleFonts.raleway(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headline6: GoogleFonts.raleway(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: color,
      ),
      subtitle1: GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: color,
      ),
      subtitle2: GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: color,
      ),
      bodyText1: GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: color,
      ),
      bodyText2: GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      ),
      button: GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: color,
      ),
      caption: GoogleFonts.raleway(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: color,
      ),
      overline: GoogleFonts.raleway(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: color,
      ),
    );
  }
}
