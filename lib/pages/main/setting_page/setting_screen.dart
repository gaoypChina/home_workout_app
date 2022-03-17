//TODO: includ android intet plus plugings
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:full_workout/pages/main/setting_page/feedback_page.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';
import 'package:full_workout/pages/main/setting_page/reset_progress.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/theme_setting_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/voice_option_setting.dart';
import 'package:full_workout/pages/subscription_page/subscription_page.dart';
import 'package:share_plus/share_plus.dart';

import '../../rate_my_app/rate_dialog_page.dart';
import '../../rate_my_app/rate_my_app.dart';

class SettingPage extends StatefulWidget {
  final Function onBack;

  SettingPage({required this.onBack});

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
    var size = MediaQuery.of(context).size;

    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      size: 14,
    );

    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.amberAccent,
      Colors.pink,
      Colors.green,
      Colors.amberAccent,
      Colors.red,
      Colors.purpleAccent,
      Colors.green,
    ];

    buildPrimeButton() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 18, bottom: 18, top: 8),
        child: ElevatedButton.icon(
          icon: FaIcon(FontAwesomeIcons.ad),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => SubscriptionPage()));
          },
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              minimumSize: Size(double.infinity, 45)),
          label: Text("Get Premium now"),
        ),
      );
    }

    getTitle(String text) {
      return Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                wordSpacing: 4,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Theme.of(context).primaryColor),
          ));
    }

    getHeader() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [
        //     Theme.of(context).primaryColor,
        //     Colors.blue,
        //   ]),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Icon(
                CupertinoIcons.person,
                size: 38,
              ),
              radius: 38,
            ),
            SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Akash Lilhare",
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "akashlilhare14@gmail.com",
                  style: TextStyle(fontSize: 16, letterSpacing: 1.2),
                )
              ],
            )
          ],
        ),
      );
    }

    getDivider() {
      return Container(
        color: Theme.of(context).dividerColor,
        height: .8,
      );
    }

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
         automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            //  getHeader(),
              getTitle("Workout"),
              CustomTile(
                icon: Icons.person_outline_sharp,
                title: "Profile",
                trailing: trailingIcon,
                onPress: () => Navigator.of(context)
                    .pushNamed(ProfileSettingScreen.routeName),
              ),
              getDivider(),
              CustomTile(
                title: "Training Rest",
                icon: CupertinoIcons.time,
                onPress: () async {
                  int? num = await showDialog(
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
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
              ),
              getDivider(),
              CustomTile(
                icon: Icons.timer,
                title: "Countdown time",
                onPress: () async {
                  int? num = await showDialog(
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
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
              ),
              getDivider(),
              CustomTile(
                title: "Sound",
                trailing: trailingIcon,
                icon: Icons.volume_up_outlined,
                onPress: () =>
                    Navigator.of(context).pushNamed(SoundSetting.routeName),
              ),
              // getDivider(),
              // buildPrimeButton(),
              getTitle("General Settings"),
              isLoading
                  ? CustomTile(
                      title: "Keep screen",
                      icon: Icons.toggle_off_outlined,
                      trailing: CircularProgressIndicator(),
                      onPress: () {},
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
                      ),
                      title: Text(
                        "Keep screen ${enable ? "On" : "Off"}",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
              getDivider(),
              CustomTile(
                  icon: Icons.wb_sunny_outlined,
                  title: "Theme Setting",
                  onPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => ThemeSettingsPage());
                  },
                  trailing: trailingIcon),
              getDivider(),
              CustomTile(
                  icon: Icons.alarm_add_rounded,
                  title: "Set reminder",
                  onPress: () {
                    Navigator.of(context).pushNamed(ReminderTab.routeName);
                  },
                  trailing: trailingIcon),
              getDivider(),
              CustomTile(
                  icon: Icons.restart_alt,
                  title: "Restart Progress",
                  trailing: trailingIcon,
                  onPress: () => showDialog(
                      context: context, builder: (context) => ResetProgress())),
              getTitle("Voice Options"),
              CustomTile(
                  title: "Test Voice",
                  icon: Icons.volume_down_outlined,
                  trailing: trailingIcon,
                  onPress: () async {
                    MediaHelper().speak("Did you Hear the test voice");
                    bool? value = await showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmVoiceDialog();
                        });
                    if (value == false) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return OpenDeviceTTSSettingsDialog();
                          });
                    }
                  },),
              getDivider(),
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
              ),
              getDivider(),
              getTitle("Support Us"),

              // CustomTile(
              //   icon: FontAwesomeIcons.ad,
              //   title: "Remove Ads",
              //   trailing: trailingIcon,
              //   onPress: () async {
              //     final RenderObject? box = context.findRenderObject();
              //     final String text =
              //         "I\'m training with Home Workout and am getting great results. \n\nHere are workouts for every muscle group to achieve your fitness goal. no equipment is needed. \n\nDownload the app : ${constants.playStoreLink}";
              //
              //     await Share.share(
              //       text,
              //     );
              //   },
              // ),
              getDivider(),
              CustomTile(
                icon: CupertinoIcons.share,
                title: "Share With Friends",
                trailing: trailingIcon,
                onPress: () async {
                  final RenderObject? box = context.findRenderObject();
                  final String text =
                      "I\'m training with Home Workout and am getting great results. \n\nHere are workouts for every muscle group to achieve your fitness goal. no equipment is needed. \n\nDownload the app : ${constants.playStoreLink}";

                  await Share.share(
                    text,
                  );
                },
              ),
              getDivider(),
              RateAppInitWidget(
                builder: (rateMyApp) => RateDialogPage(
                  rateMyApp: rateMyApp,
                ),
              ),
              getTitle("About us"),
              CustomTile(
                icon: Icons.email_outlined,
                title: "Feedback",
                trailing: trailingIcon,
                onPress: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeedbackPage()));

                },
              ),
              getDivider(),
              CustomTile(
                icon: FontAwesomeIcons.questionCircle,
                title: "FAQ",
                onPress: () =>
                    Navigator.of(context).pushNamed(FAQPage.routeName),
                trailing: trailingIcon,
              ),
              getDivider(),
              CustomTile(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                trailing: trailingIcon,
                onPress: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy())),
              ),
              getDivider(),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.only(
                    top: 18.0, bottom: 18, left: 18, right: 18),
                child: Column(
                  children: [
                    // Container(
                    //   height: 45,
                    //   width: double.infinity,
                    //   child: OutlinedButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       "LOG OUT",
                    //     ),
                    //     style: OutlinedButton.styleFrom(
                    //       primary: Colors.red,
                    //       side: BorderSide(width: .65, color: Colors.red),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        "Version - ".toUpperCase() +
                            constants.versionNumber
                        //    + " (beta)".toUpperCase()
                        ,
                        style: TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(.7),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final Function onPress;

  CustomTile(
      {required this.title,
      required this.icon,
      required this.trailing,
      required this.onPress,
});

  @override
  Widget build(BuildContext context) {

    return ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 24),
        leading: Icon(
          icon,
        ),
        onTap: () => onPress(),
        title: Text(
          title,
          //   style: constants.listTileTitleStyle,
        ),
        trailing: trailing);
  }
}