import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/mediaHelper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:full_workout/pages/main/setting_page/feedback_page.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_setting_page.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';
import 'package:full_workout/pages/main/setting_page/reset_progress.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/theme_setting_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/voice_option_setting.dart';
import 'package:full_workout/pages/subscription_page/subscription_page.dart';
import 'package:full_workout/provider/connectivity_provider.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/dialogs/connectivity_error_dialog.dart';
import '../../rate_my_app/rate_dialog_page.dart';
import '../../rate_my_app/rate_my_app.dart';
import '../../subscription_page/subscribed_page.dart';
import 'backup_data_page.dart';
import 'delete_account.dart';

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
    var subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    var connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;


    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      size: 15,
    );

    buildPrimeButton() {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 0, top: 16),
        child: ElevatedButton.icon(
          icon: FaIcon(FontAwesomeIcons.ad),
          onPressed: () async {
            bool isConnected = await connectivityProvider.isNetworkConnected;
            if (isConnected) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => SubscriptionPage()));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => ConnectivityErrorDialog());
            }
          },
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22))),
              minimumSize: Size(double.infinity, 50)),
          label: Text("Get Premium now"),
        ),
      );
    }

    getTitle(String text) {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                wordSpacing: 4,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isDark?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8):null),
          ));
    }

    getDivider() {
      return Container(
        color: Colors.blueGrey.shade500.withOpacity(.1),
        height: .5,
      );
    }

    Color cardColor = Theme.of(context).scaffoldBackgroundColor;

    return WillPopScope(
      onWillPop: () => widget.onBack(),
      child: Scaffold(
        backgroundColor:isDark ?  Theme.of(context).appBarTheme.backgroundColor:Colors.blueGrey.shade300.withOpacity(.1),
        appBar: AppBar(
         //  backgroundColor:Theme.of(context).cardColor,
          elevation: .5,
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

              BackupDataCard(),
              getTitle("Workout"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Container(

                  color: cardColor,
                  child: Column(
                    children: [

                      CustomTile(
                        icon: Icons.person_outline_sharp,
                        title: "Edit Profile",
                        trailing: trailingIcon,
                        onPress: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (builder) => ProfileSettingPage())),
                      ),
                      getDivider(),
                      CustomTile(
                        title: "Training Rest",
                        icon: CupertinoIcons.time,
                        onPress: () async {
                          int? num = await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return WorkoutTimePicker(
                                value: trainingRest.toInt(),
                                maximumVal: 180,
                                minimumVal: 5,
                              );
                            },
                          );

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
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                      getDivider(),
                      CustomTile(
                        icon: Icons.timer_outlined,
                        title: "Countdown time",
                        onPress: () async {
                          int? num = await showMaterialModalBottomSheet(
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
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                      getDivider(),
                      CustomTile(
                        title: "Sound",
                        trailing: trailingIcon,
                        icon: Icons.volume_up_outlined,
                        onPress: () => Navigator.of(context)
                            .pushNamed(SoundSetting.routeName),
                      ),
                    ],
                  ),
                ),
              ),
              if (!subscriptionProvider.isProUser) buildPrimeButton(),
              getTitle("General Settings"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Container(

                  color: cardColor,
                  child: Column(
                    children: [
                      isLoading
                          ? CustomTile(
                              title: "Keep screen",
                              icon: Icons.toggle_off_outlined,
                              trailing: CircularProgressIndicator(),
                              onPress: () {},
                            )
                          : SwitchListTile(
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 2),
                              value: enable,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                spHelper.saveBool(spKey.awakeScreen, value);
                                spHelper.saveInt(spKey.initPage, 4);
                                setState(() {
                                  enable = value;
                                });
                              },
                              secondary: Icon(
                                Icons.toggle_off_outlined,
                          color:      Theme.of(context).iconTheme.color,
                              ),
                              title: Text(
                                "Keep screen ${enable ? "On" : "Off"}",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                      getDivider(),
                      CustomTile(
                          icon: Icons.lightbulb_outline,
                          title: "Theme Setting",
                          onPress: () {
                            showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => ThemeSettingsPage(),
                            );
                          },
                          trailing: trailingIcon),
                      getDivider(),
                      CustomTile(
                          icon: Icons.alarm_add_rounded,
                          title: "Set reminder",
                          onPress: () {
                            Navigator.of(context)
                                .pushNamed(ReminderTab.routeName);
                          },
                          trailing: trailingIcon),
                      if (subscriptionProvider.isProUser) getDivider(),
                      if (subscriptionProvider.isProUser)
                        CustomTile(
                          title: "Subscription Settings",
                          trailing: trailingIcon,
                          icon: Icons.subscriptions_outlined,
                          onPress: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SubscribedPage())),
                        ),
                      getDivider(),
                      CustomTile(
                          icon: Icons.restart_alt,
                          title: "Reset Progress",
                          trailing: trailingIcon,
                          onPress: () async {
                            bool isConnected =
                                await connectivityProvider.isNetworkConnected;
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return isConnected
                                      ? ResetProgressDialog(
                                          title: "Rest Progress",
                                          subtitle:
                                              "After resetting process, all workout plan will restart from day 1 ",
                                        )
                                      : ConnectivityErrorDialog();
                                });
                          }),
                      getDivider(),
                      CustomTile(
                          icon: Icons.delete_outlined,
                          title: "Delete Account",
                          trailing: trailingIcon,
                          onPress: () async {
                            bool isConnected =
                            await connectivityProvider.isNetworkConnected;

                            return isConnected ? showDialog(
                              context: context,
                              builder: (builder) => DeleteAccountDialog()):ConnectivityErrorDialog();
                          })
                    ],
                  ),
                ),
              ),
              getTitle("Voice Options"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Container(

                  color: cardColor,
                  child: Column(
                    children: [
                      CustomTile(
                        title: "Test Voice",
                        icon:  Icons.volume_up_outlined,
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
                        },
                      ),
                      getDivider(),
                      CustomTile(
                        title: "Device TTS Setting",
                        icon: Icons.settings_outlined,
                        trailing: trailingIcon,
                        onPress: () async {
                          try {
                            AndroidIntent intent = AndroidIntent(
                              action: 'com.android.settings.TTS_SETTINGS',
                            );
                            await intent.launch();
                          } catch (e) {
                            Constants().getToast(
                                "Open TTS setting from device setting");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              getTitle("Support Us"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                color: Colors.orange.withOpacity(.0),
                child: Container(
                  color: cardColor,
                  child: Column(
                    children: [
                      if (!subscriptionProvider.isProUser)
                        CustomTile(
                          icon: FontAwesomeIcons.ad,

                          title: "Remove Ads",
                          trailing: trailingIcon,
                          onPress: () async {
                            bool isConnected = await connectivityProvider.isNetworkConnected;
                            if (isConnected) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (builder) => SubscriptionPage()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => ConnectivityErrorDialog());
                            }
                          },
                        ),
                      if (!subscriptionProvider.isProUser) getDivider(),
                      CustomTile(
                        icon: Icons.share_outlined,
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
                    ],
                  ),
                ),
              ),
              getTitle("About us"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  color: cardColor,
                  child: Column(
                    children: [
                      CustomTile(
                        icon: Icons.email_outlined,
                        title: "Feedback",
                        trailing: trailingIcon,
                        onPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FeedbackPage()));
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
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy())),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              // SocialIcons(),
              SizedBox(
                height: 70,
              ),
              Center(
                  child: Text(
                "Made With ❤ in India".toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5),
              )),
              Container(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Version - ".toUpperCase() +
                            constants.versionNumber +
                            " (beta)".toUpperCase(),
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatefulWidget {
  const SocialIcons({Key? key}) : super(key: key);

  @override
  _SocialIconsState createState() => _SocialIconsState();
}

class _SocialIconsState extends State<SocialIcons> {
  @override
  Widget build(BuildContext context) {
    buildIcon({required String imgScr}) {
      return Container(
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(imgScr),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildIcon(
            imgScr: "https://cdn-icons-png.flaticon.com/512/174/174855.png"),
        buildIcon(
            imgScr: "https://cdn-icons-png.flaticon.com/512/174/174848.png"),
        buildIcon(
            imgScr: "https://cdn-icons-png.flaticon.com/512/174/174879.png"),
        buildIcon(
            imgScr: "https://cdn-icons-png.flaticon.com/512/174/174857.png"),
        buildIcon(
            imgScr: "https://cdn-icons-png.flaticon.com/512/174/174876.png"),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final Function onPress;

  CustomTile({
    required this.title,
    required this.icon,
    required this.trailing,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 12, right: 14),
      leading: Icon(
        icon,
       color:Theme.of(context).iconTheme.color,
      ),
      onTap: () => onPress(),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400
        ),
      ),
      trailing: trailing,
    );
  }
}