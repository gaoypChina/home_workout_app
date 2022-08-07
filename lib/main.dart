import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
import '../widgets/connection_error_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc_provider/connectivity_state_bloc.dart';
import 'constants/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  tz.initializeTimeZones();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.black));

  runApp(Phoenix(child: MyApp()));
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
                          return FutureBuilder(
                              future: Provider.of<SubscriptionProvider>(context,
                                      listen: false)
                                  .setSubscriptionDetails(),
                              builder: (context, snapshot) {
                                return MaterialApp(
                                  title: 'Home Workout',
                                  darkTheme: darkThemeData,
                                  theme: lightThemeData,
                                  routes: {
                                    '/': (ctx) => SplashPage(),
                                    DetailInputPage.routeName: (ctx) =>
                                        DetailInputPage(),
                                    ReminderTab.routeName: (ctx) =>
                                        ReminderTab(),
                                    FAQPage.routeName: (ctx) => FAQPage(),
                                    ConnectionErrorPage.routeName: (ctx) =>
                                        ConnectionErrorPage(),
                                    MainPage.routeName: (ctx) =>
                                        MainPage(index: 0),
                                    ProfileSettingPage.routeName: (ctx) =>
                                        ProfileSettingPage(),
                                    SoundSetting.routeName: (ctx) =>
                                        SoundSetting(),
                                    WorkoutDetailReport.routeName: (ctx) =>
                                        WorkoutDetailReport(),
                                    //  LoginPage.routeName: (ctx) => LoginPage()
                                  },
                                  debugShowCheckedModeBanner: false,
                                );
                              });
                        }),
                      );
                    });
              });
        });
  }
}
