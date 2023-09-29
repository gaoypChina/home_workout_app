import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// dark theme
var darkBackgroundColor = Color(0xff242526);
Color darkAppBarColor = Color(0xff18191A);
Color darkPrimaryColor = Colors.blue;
Color darkSecondaryColor = Color(0xff3A3B3C);

/// light theme
Color lightBackgroundColor = Colors.white;
Color lightAppbarColor = Colors.white;
Color lightCardColor = Color(0xffF7F9F9);
Color lightPrimaryColor = Colors.blue.shade700;

var lightTheme = ThemeData(
  //textTheme: lightTextTheme,
  // useMaterial3: true,

  primaryColor: Colors.blue.shade700,
  cardColor: lightCardColor,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  dialogBackgroundColor: lightCardColor,
  dividerColor: Colors.grey.shade200.withOpacity(.8),
  dividerTheme: DividerThemeData(
    thickness: .8,
    color: Colors.grey.shade200.withOpacity(.7),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(fontSize: 40),
    unselectedLabelStyle:  TextStyle(fontSize: 40),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: lightPrimaryColor,
  )),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: lightPrimaryColor,
  )),
  iconTheme: IconThemeData(
    color: Colors.grey.shade700,
  ),
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
);

var darkTheme = ThemeData(
  primaryColor: darkPrimaryColor,
  cardColor: darkSecondaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBackgroundColor,
  appBarTheme: AppBarTheme(
      elevation: .5,
      shadowColor: Colors.white,
      backgroundColor: darkAppBarColor,
      titleTextStyle: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
  primarySwatch: Colors.blue,

  dialogBackgroundColor: darkSecondaryColor,

  dividerTheme: DividerThemeData(color: darkSecondaryColor), bottomAppBarTheme: BottomAppBarTheme(color: darkAppBarColor),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(color:darkPrimaryColor)),
  //   contentPadding: EdgeInsets.symmetric(horizontal: 16),
  //   focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: BorderSide(color: darkPrimaryColor)),
  // )
);

var lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.openSans(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.black),
  displayMedium: GoogleFonts.openSans(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.black87),
  displaySmall: GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.openSans(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black),
  bodyMedium: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black87),
  labelLarge: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),

);

var darkTextTheme = TextTheme(
  displayLarge: GoogleFonts.openSans(
    fontSize: 97,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    color: Colors.white,
  ),
  displayMedium: GoogleFonts.openSans(
      fontSize: 61,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
  displaySmall: GoogleFonts.openSans(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.white),
  headlineMedium: GoogleFonts.openSans(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  headlineSmall: GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.openSans(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyMedium: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  labelLarge: GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.white,
  ),

);
