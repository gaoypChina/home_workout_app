import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/pages/subscription_page/subscription_page.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../helper/notification_helper.dart';
import '../../pages/detail_input_page/detail_input_page.dart';
import '../../pages/main/report_page/workout_report/workout_detail_report.dart';
import '../../pages/main/setting_page/faq_page.dart';
import '../../pages/main/setting_page/profile_setting_page.dart';
import '../../pages/main/setting_page/reminder_screen.dart';
import '../../pages/main/setting_page/sound_settings_page.dart';
import '../../pages/main_page.dart';
import '../../pages/splash_page.dart';
import '../../provider/ads_provider.dart';
import '../provider/auth_provider.dart';
import '../provider/backup_provider.dart';
import '../provider/connectivity_provider.dart';
import '../provider/subscription_provider.dart';
import '../provider/theme_provider.dart';
import '../provider/user_detail_provider.dart';
import '../provider/weight_report_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'constants/app_theme.dart';
import 'helper/firebase_notification_helper.dart';
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotificationHelper.initNotifications();

  MobileAds.instance.initialize();
  tz.initializeTimeZones();
  oneSignalSetup();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.black));
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(MyApp());
}

oneSignalSetup(){
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("3c71a890-0ef2-4790-b946-0de8395649b0");

  OneSignal.Notifications.requestPermission(true);
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
          ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
          ChangeNotifierProvider(create: (context) => WeightReportProvider()),
          ChangeNotifierProvider(create: (context) => AdsProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => BackupProvider()),
          ChangeNotifierProvider(create: (context) => UserDetailProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        builder: (context, _) {
          return FutureBuilder<AdaptiveThemeMode>(
              future:
                  Provider.of<ThemeProvider>(context, listen: false).getTheme(),
              initialData: AdaptiveThemeMode.system,
              builder: (context, snapShot) {
              //  Provider.of<BackupProvider>(context, listen: false).dailyBackup();
                return AdaptiveTheme(
                    light: lightTheme,
                    dark: darkTheme,
                    initial: snapShot.hasData
                        ? snapShot.data ?? AdaptiveThemeMode.system
                        : AdaptiveThemeMode.system,
                    builder: (lightThemeData, darkThemeData) {
                      return MaterialApp(
                        navigatorKey: navigatorKey,

                        title: 'Home Workout',
                        darkTheme: darkThemeData,
                        theme: lightThemeData,
                        localizationsDelegates: [
                          MonthYearPickerLocalizations.delegate,
                        ],
                        home:SplashPage(),
                        routes: {
                          DetailInputPage.routeName: (ctx) =>
                              DetailInputPage(),
                          ReminderTab.routeName: (ctx) =>
                              ReminderTab(),
                          FAQPage.routeName: (ctx) => FAQPage(),
                          MainPage.routeName: (ctx) =>
                              MainPage(index: 0),
                          ProfileSettingPage.routeName: (ctx) =>
                              ProfileSettingPage(),
                          SoundSetting.routeName: (ctx) =>
                              SoundSetting(),
                          WorkoutDetailReport.routeName: (ctx) =>
                              WorkoutDetailReport(),
                          SubscriptionPage.routeName: (ctx) =>
                              SubscriptionPage(showCrossButton: false,),
                          //  LoginPage.routeName: (ctx) => LoginPage()
                        },
                        debugShowCheckedModeBanner: false,
                      );
                    });
              });
        });
  }
}

