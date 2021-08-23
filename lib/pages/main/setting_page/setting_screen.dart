import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';
import 'package:full_workout/pages/main/setting_page/reset_progress.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:full_workout/pages/main/setting_page/voice_option_setting.dart';
import 'package:share/share.dart';
import 'package:device_info/device_info.dart';

import '../../../main.dart';

class SettingPage extends StatefulWidget {
  final Function onBack;

  SettingPage({this.onBack});

  static const routeName = "setting-page";

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  Constants constants = Constants();
  double trainingRest = 15;
  double countdownTime = 10;
  bool enable = true;
  bool isLoading = true;

  getScreenEnable() async {
    enable = await spHelper.loadBool(spKey.awakeScreen) ?? true;
    setState(() {});
  }

  loadRestTime() async {
    await spHelper.loadDouble(spKey.trainingRest).then((value) {
      setState(() {
        trainingRest = (value == null) ? 30.0 : value;
      });
    });
    await spHelper.loadDouble(spKey.countdownTime).then((value) {
      setState(() {
        countdownTime = (value == null) ? 10.0 : value;
      });
    });
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    loadRestTime();
    getScreenEnable();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    spHelper.saveInt(spKey.initPage, 0);
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var size = MediaQuery.of(context).size;

    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey,
      size: 16,
    );

    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.pink,
      Colors.amberAccent,
      Colors.blue,
      Colors.green,
      Colors.amberAccent,
      Colors.red,
      Colors.purpleAccent,
      Colors.green,
    ];

    getTitle(String text) {
      return Container(
          color: isDark ? Colors.black : Colors.grey.shade50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Text(
            text,
            style: textTheme.subtitle1.copyWith(
                wordSpacing: 4,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color:isDark? Colors.blue:Colors.blue.shade700),
          ));
    }

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: NestedScrollView(
            controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                  ),
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  automaticallyImplyLeading: false,
                  expandedHeight: 150.0,
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Settings",
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitle("Workout"),
                  CustomTile(
                    color: colorList[0],
                    icon: Icons.person,
                    title: "Profile",
                    trailing: trailingIcon,
                    onPress: () => Navigator.of(context)
                        .pushNamed(ProfileSettingScreen.routeName),
                  ),
                  CustomTile(
                    title: "Training Rest",
                    icon: AntDesign.rest,
                    color: colorList[2],
                    onPress: () async {
                      int num = await showDialog(
                          context: context,
                          builder: (context) {
                            return WorkoutTimePicker(
                              value: trainingRest.toInt(),
                              maximumVal: 180,
                              minimumVal: 5,
                            );
                          });
                      if (num != null) {
                        await spHelper.saveDouble(
                            spKey.trainingRest, num.toDouble());
                        setState(() {
                          trainingRest = num.toDouble();
                        });
                      }
                    },
                    trailing: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            trainingRest.toStringAsFixed(0) + " Sec",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                  CustomTile(
                    color: colorList[3],
                    icon: Icons.timer,
                    title: "Countdown time",
                    onPress: () async {
                      int num = await showDialog(
                          context: context,
                          builder: (context) {
                            return WorkoutTimePicker(
                              value: countdownTime.toInt(),
                              minimumVal: 10,
                              maximumVal: 15,
                            );
                          });
                      if (num != null) {
                        await spHelper.saveDouble(
                            spKey.countdownTime, num.toDouble());
                        setState(() {
                          countdownTime = num.toDouble();
                        });
                      }
                    },
                    trailing: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            countdownTime.toStringAsFixed(0) + " Sec",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                  CustomTile(
                    color: colorList[2],
                    title: "Sound",
                    trailing: trailingIcon,
                    icon: Icons.volume_up,
                    onPress: () =>
                        Navigator.of(context).pushNamed(SoundSetting.routeName),
                  ),
                  getTitle("General Settings"),
                  isLoading
                      ? CustomTile(
                          title: "Keep screen",
                          icon: Icons.toggle_off_outlined,
                          trailing: CircularProgressIndicator(),
                          onPress: () {},
                          color: colorList[3],
                        )
                      : SwitchListTile(
                          contentPadding: EdgeInsets.only(left: 20, right: 16),
                          value: enable,
                          activeColor: Colors.blue.shade700,
                          onChanged: (value) {
                            spHelper.saveBool(spKey.awakeScreen, value);
                            spHelper.saveInt(spKey.initPage, 4);
                            setState(() {
                              enable = value;
                            });
                          },
                          secondary: Icon(
                            Icons.toggle_off_outlined,
                            color: colorList[3],
                          ),
                          title: Text(
                            "Keep screen ${enable ? "On" : "Off"}",
                            style: constants.listTileTitleStyle,
                          ),
                        ),
                  CustomTile(
                      color: colorList[4],
                      icon: Icons.alarm_add_rounded,
                      title: "Set reminder",
                      onPress: () {
                        Navigator.of(context).pushNamed(ReminderTab.routeName);
                      },
                      trailing: trailingIcon),
                  CustomTile(
                      color: colorList[2],
                      icon: Icons.restart_alt,
                      title: "Restart Progress",
                      trailing: trailingIcon,
                      onPress: () => showDialog(
                          context: context,
                          builder: (context) => ResetProgress())),
                  getTitle("Voice Options"),
                  CustomTile(
                      title: "Test Voice",
                      icon: Icons.volume_down,
                      trailing: trailingIcon,
                      onPress: () async {
                        bool value = await MediaHelper()
                            .speak("Did you Hear the test voice")
                            .then((value) => showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmVoiceDialog();
                                }));
                        if (value == false) {
                      await   showDialog(
                              context: context,
                              builder: (context) {
                                return OpenDeviceTTSSettingsDialog();
                              });
                        }
                      },
                      color: colorList[6]),
                  CustomTile(
                      title: "Device TTS Setting",
                      icon: Icons.settings_applications,
                      trailing: trailingIcon,
                      onPress: () async {
                        AndroidIntent intent = AndroidIntent(
                          action: 'com.android.settings.TTS_SETTINGS',
                        );
                        await intent.launch();
                      },
                      color: colorList[1]),
                  getTitle("Support Us"),
                  CustomTile(
                    color: colorList[5],
                    icon: Icons.share,
                    title: "Share With Friends",
                    trailing: trailingIcon,
                    onPress: () async {
                      final RenderBox box = context.findRenderObject();
                      final String text = "my app link";
                      await Share.share(text,
                          subject: "",
                          sharePositionOrigin:
                              box.globalToLocal(Offset.zero) & box.size);
                    },
                  ),
                  CustomTile(
                    color: colorList[6],
                    icon: Icons.star,
                    title: "5 star Ratting",
                    trailing: trailingIcon,
                    onPress: () async{
                      if (Platform.isAndroid) {
                        AndroidIntent intent = AndroidIntent(
                          action: 'action_view',
                          data: 'https://play.google.com/store/apps/details?'
                              'id=com.google.android.apps.myapp',
                          arguments: {'authAccount': "currentUserEmail"},
                        );
                        await intent.launch();
                      }
                    },
                  ),
                  getTitle("About us"),
                  CustomTile(
                    color: colorList[7],
                    icon: Icons.email,
                    title: "Feedback",
                    trailing: trailingIcon,
                    onPress: () async {
                      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                      AndroidDeviceInfo info = await deviceInfo.androidInfo;

                      String toSend =
                          "version: ${info.version.release.toString()}, brand: ${info.brand.toString()}, display : ${size.height.toInt()}x${size.width.toInt()}\n\n";

                      final Email email = Email(
                        body: toSend,
                        subject: 'Home Workout Feedback',
                        recipients: ['workoutfeedback@gmail.com'],
                        isHTML: false,
                      );

                      try {
                        await FlutterEmailSender.send(email);
                      } catch (e) {
                        constants.getToast("Not able to send email");
                      }
                    },
                  ),
                  CustomTile(
                    color: colorList[8],
                    icon: FontAwesome.question_circle,
                    title: "FAQ",
                    onPress: () =>
                        Navigator.of(context).pushNamed(FAQPage.routeName),
                    trailing: trailingIcon,
                  ),
                  CustomTile(
                    color: colorList[9],
                    icon: Icons.privacy_tip,
                    title: "Privacy Policy",
                    trailing: trailingIcon,
                    onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Version "+constants.versionNumber,
                        style: TextStyle(fontSize: 14,color: Colors.grey),
                      ),
                    ),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final Function onPress;
  final Color color;

  CustomTile(
      {@required this.title,
      @required this.icon,
      @required this.trailing,
      @required this.onPress,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    return ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 24),
        leading: Icon(
          icon,
          color: color.withOpacity(.9),
        ),
        onTap: onPress,
        title: Text(
          title,
          style: constants.listTileTitleStyle,
        ),
        trailing: trailing);
  }
}