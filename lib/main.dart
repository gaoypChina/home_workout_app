import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:full_workout/pages/main/report_page/details_screen.dart';
import 'package:full_workout/pages/main/report_page/report_page.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_tab.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:full_workout/pages/main_page.dart';
import 'package:full_workout/pages/services/faq_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // statusBarColor: Colors.blue.shade700,
    // statusBarIconBrightness: Brightness.light,
    // statusBarBrightness: Brightness.light,
    // systemNavigationBarDividerColor: Colors.blue.shade700
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // darkTheme:
      // ThemeData(
      //     brightness: Brightness.dark,
      //     primarySwatch: Colors.blue,
      //     textTheme: textTheme,
      //     inputDecorationTheme: InputDecorationTheme(
      //       filled: true,
      //       fillColor: Colors.grey.shade800,
      //       enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(8),
      //           borderSide: BorderSide(color: Colors.transparent)),
      //       contentPadding: EdgeInsets.symmetric(horizontal: 16),
      //       focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.circular(8),
      //           borderSide: BorderSide(color: Colors.transparent)),
      //     )),
      theme:
      //theme[1],
      ThemeData(
              //  primarySwatch: Colors.blue,
              primaryColor: Colors.blue.shade700,
              textTheme: textTheme,
              radioTheme: RadioThemeData(
                  fillColor: MaterialStateProperty.all(Colors.blue.shade700),
                ),

              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.blue.shade50,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.transparent)),
              )),
      initialRoute: "/main",
      routes: {
        '/': (ctx) => MainPage(),
        DetailsScreen.routeName: (ctx) => DetailsScreen(),
        ReminderTab.routeName: (ctx) => ReminderTab(),
        FAQPage.routeName: (ctx) => FAQPage(),
        ReportPage.routeName: (ctx) => ReportPage(),
        MainPage.routeName: (ctx) => MainPage(),
        ProfileSettingScreen.routeName: (ctx) => ProfileSettingScreen(),
        SoundSetting.routeName: (ctx) => SoundSetting(),
        TrainingSettingsScreen.routeName: (ctx) => TrainingSettingsScreen(),
      },
      builder: EasyLoading.init(),

      debugShowCheckedModeBanner: false,
    );
  }
}




var textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.montserrat(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.montserrat(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.blue.shade700),
  caption: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);








