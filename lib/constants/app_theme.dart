import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// dark theme
var darkBackgroundColor = Color(0xff15202B);
Color darkAppBarColor = Color(0xff15202B);
Color darkPrimaryColor = Colors.blue;
Color darkSecondaryColor = Color(0xff192734);
Color darkInputBgColor = Color(0xff253341);

/// light theme
Color lightBackgroundColor = Colors.white;
Color lightAppbarColor = Colors.white;
Color lightCardColor = Color(0xffF7F9F9);

var lightTheme = ThemeData(
    primaryColor: Colors.blue.shade700,
    cardColor: Colors.grey.shade50,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    dialogBackgroundColor: lightCardColor,
    dividerColor: Colors.grey.shade200.withOpacity(.8),
    dividerTheme: DividerThemeData(
      thickness: .8,
      color: Colors.grey.shade200.withOpacity(.7),
    ),
    iconTheme: IconThemeData(color: Color(0xff919CA4)),
    // TextStyle: lightTextStyle,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: .5,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black)),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.blue.shade700),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700)),
    ));

var darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    cardColor: darkSecondaryColor,
    bottomAppBarColor: darkAppBarColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,

    appBarTheme: AppBarTheme(
        elevation: 1,
        shadowColor: Colors.white,
        backgroundColor: darkAppBarColor,
        titleTextStyle: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
    primarySwatch: Colors.blue,

    dialogBackgroundColor: darkSecondaryColor,

    //  TextStyle: darkTextStyle,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.blue.shade700),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blue.shade100),
    ),
    dividerTheme: DividerThemeData(color: darkSecondaryColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkInputBgColor,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade700)),
    ));

var lightTextTheme = TextTheme(
  headline1: GoogleFonts.lato(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.black),
  headline2: GoogleFonts.lato(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.black87),
  headline3: GoogleFonts.lato(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.lato(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.lato(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black),
  bodyText2: GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black87),
  button: GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.lato(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.lato(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

var darkTextTheme = TextTheme(
  headline1: GoogleFonts.lato(
    fontSize: 97,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: Colors.white,
  ),
  headline2: GoogleFonts.lato(
      fontSize: 61,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
  headline3: GoogleFonts.lato(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.white),
  headline4: GoogleFonts.lato(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  headline5: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.lato(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.lato(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.lato(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyText2: GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  button: GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.white,
  ),
  caption: GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.lato(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
