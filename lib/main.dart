import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_workout/helper/notification_helper.dart';
import 'package:full_workout/pages/login_page.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main_page.dart';
import 'package:full_workout/provider/ads_provider.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:full_workout/provider/theme_provider.dart';
import 'package:full_workout/provider/weight_report_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc_provider/connectivity_state_bloc.dart';
import 'constants/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  tz.initializeTimeZones();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.init(initScheduled: true);
    listenNotification();
  }

  void listenNotification() =>
      NotificationHelper.onNotifications.stream.listen(onClickedNotification);

  onClickedNotification(String payload) => Navigator.of(context).pushNamed("/");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SubscriptionProvider()),
          ChangeNotifierProvider(create: (context) => WeightReportProvider()),
          ChangeNotifierProvider(create: (context) => AdsProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        builder: (context, _) {
          return FutureBuilder<AdaptiveThemeMode>(
              future:
                  Provider.of<ThemeProvider>(context, listen: false).getTheme(),
              initialData: AdaptiveThemeMode.system,
              builder: (context, snapShot) {
                return AdaptiveTheme(
                    light: lightTheme,
                    dark: darkTheme,
                    initial: snapShot.hasData
                        ? snapShot.data ?? AdaptiveThemeMode.system
                        : AdaptiveThemeMode.system,
                    builder: (lightThemeData, darkThemeData) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<ConnectivityCubit>(
                            create: (context) => ConnectivityCubit(
                              connectivity: Connectivity(),
                            ),
                          )
                        ],
                        child:
                            BlocBuilder<ConnectivityCubit, ConnectivityState>(
                                builder: (context, state) {
                          return MaterialApp(
                            title: 'Home Workout',
                            darkTheme: darkThemeData,
                            theme: lightThemeData,
                            routes: {
                              '/': (ctx) {
                                if (false) {
                                  return LoginPage();
                                } else {
                                  return MainPage(
                                    index: 0,
                                  );
                                }
                              },
                              ReminderTab.routeName: (ctx) => ReminderTab(),
                              FAQPage.routeName: (ctx) => FAQPage(),
                              //   ReportPage.routeName: (ctx) => ReportPage(),
                              MainPage.routeName: (ctx) => MainPage(
                                    index: 0,
                                  ),
                              ProfileSettingScreen.routeName: (ctx) =>
                                  ProfileSettingScreen(),
                              SoundSetting.routeName: (ctx) => SoundSetting(),
                              //  WeightReportDetail.routeName: (ctx) => WeightReportDetail(index: 0,),
                              WorkoutDetailReport.routeName: (ctx) =>
                                  WorkoutDetailReport(),
                              LoginPage.routeName: (ctx) => LoginPage()
                              //  SettingPage.routeName: (ctx) => SettingPage()
                            },
                            debugShowCheckedModeBanner: false,
                          );
                        }),
                      );
                    });
              });
        });
  }
}
