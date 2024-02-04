import 'dart:math';

import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/constant.dart';
import '../../../helper/mediaHelper.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../pages/main/setting_page/contact_us_page/contact_us_page.dart';
import '../../../pages/main/setting_page/faq_page.dart';
import '../../../pages/main/setting_page/feedback_page.dart';
import '../../../pages/main/setting_page/privacy_policy.dart';
import '../../../pages/main/setting_page/profile_setting_page.dart';
import '../../../pages/main/setting_page/reminder_screen.dart';
import '../../../pages/main/setting_page/reset_progress.dart';
import '../../../pages/main/setting_page/sound_settings_page.dart';
import '../../../pages/main/setting_page/theme_setting_page.dart';
import '../../../pages/main/setting_page/training_settings_screen.dart';
import '../../../pages/main/setting_page/voice_option_setting.dart';
import '../../../pages/subscription_page/subscription_page.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/backup_provider.dart';
import '../../../provider/connectivity_provider.dart';
import '../../../provider/subscription_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../widgets/dialogs/connectivity_error_dialog.dart';
import '../../../widgets/loading_indicator.dart';
import '../../login_page/login_page.dart';
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

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  bool get isbouncing {
    return _scrollController.hasClients &&
        _scrollController.offset > (250 - kToolbarHeight);
  }

  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  Constants constants = Constants();
  double trainingRest = 15;
  double countdownTime = 10;
  bool enable = true;
  bool isLoading = true;
  String name = "User";
  late String lastSync = DateTime.now().toIso8601String();

  loadData() async {
    enable = await spHelper.loadBool(spKey.awakeScreen) ?? true;
    trainingRest = await spHelper.loadDouble(spKey.trainingRest) ?? 30;
    countdownTime = await spHelper.loadDouble(spKey.countdownTime) ?? 10;
    name = await spHelper.loadString(spKey.name) ?? "User";
    lastSync = await spHelper.loadString(spKey.backupTime) ??
        DateTime.now().toIso8601String();
  }

  initData() async {
    setState(() {
      isLoading = true;
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    spHelper.saveInt(spKey.initPage, 0);

    await loadData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    var subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    var connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);

    var backupProvider = Provider.of<BackupProvider>(context, listen: false);
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    String getParsedTime({required String dateTime}) {
      String date = DateFormat.yMMMd().format(DateTime.parse(dateTime));
      String time = DateFormat.jm().format(DateTime.parse(dateTime));
      return "$date $time";
    }

    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      size: 16,
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
    );

    getTitle(String text) {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16.0, top: 24, bottom: 4),
          child: Text(
            text,
            style: TextStyle(
                wordSpacing: 4,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isDark ? null : Colors.black.withOpacity(.9)),
          ));
    }

    buildProfileCard() {
      return Column(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18))),
                  enableDrag: true,
                  isDismissible: true,
                  context: context,
                  builder: (context) {
                    return DataSyncModal(
                      userName: name,
                      onSync: () {
                        var provider =
                            Provider.of<BackupProvider>(context, listen: false);

                        provider.syncData(
                            context: context,
                            isLoginPage: false,
                            showMsg: true);
                      },
                    );
                  });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12)
                  .copyWith(bottom: 4, top: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade700.withOpacity(.2),
                    child: Text(
                      name[0].toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          color: isDark
                              ? Colors.white70
                              : Colors.black.withOpacity(.8),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        "Last Sync : ${getParsedTime(dateTime: lastSync)}",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        bool isConnected =
                            await connectivityProvider.isNetworkConnected;

                        if (!isConnected) {
                          showDialog(
                              context: context,
                              builder: (builder) => ConnectivityErrorDialog());
                          return;
                        }

                        showDialog(
                            context: context,
                            builder: (builder) {
                              return CustomLoadingIndicator(
                                msg: "Syncing",
                              );
                            });

                        await backupProvider.syncData(
                            context: context,
                            isLoginPage: false,
                            showMsg: true);
                        initData();

                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.sync))
                ],
              ),
            ),
          ),
          // Container(
          //   height: 1,
          //   color: Colors.grey.withOpacity(.2),
          // )
        ],
      );
    }

    buildProCard() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue.shade800.withOpacity(isDark ? .8 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pro Member",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "All features unlocked!",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white70),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  InkWell(
                    onTap: () async {
                      bool isConnected =
                          await connectivityProvider.isNetworkConnected;
                      if (isConnected) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => SubscriptionPage(
                                  showCrossButton: false,
                                )));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => ConnectivityErrorDialog());
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Text(
                        "Upgrade",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(.8)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: .8,
                child: Image.asset("assets/icons/gift.png"),
              ),
            )
          ],
        ),
      );
    }

    Color cardColor = Theme.of(context).scaffoldBackgroundColor;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child:
                Consumer<BackupProvider>(builder: (context, backupProvider, _) {
              return WillPopScope(
                  onWillPop: () => widget.onBack(),
                  child: Column(
                    children: [
                      buildProfileCard(),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: isShrink ? BouncingScrollPhysics() : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!subscriptionProvider.isProUser)
                                SizedBox(
                                  height: 12,
                                ),
                              if (!subscriptionProvider.isProUser)
                                buildProCard(),
                              getTitle("Workout"),
                              Container(
                                color: cardColor,
                                child: Column(
                                  children: [
                                    CustomTile(
                                      icon: Icons.person_outline_sharp,
                                      color: Colors.blue.shade800,
                                      title: "Edit Profile",
                                      trailing: trailingIcon,
                                      onPress: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    ProfileSettingPage()));
                                        name = await spHelper
                                                .loadString(spKey.name) ??
                                            "User";
                                        setState(() {});
                                      },
                                    ),

                                    CustomTile(
                                      color: Colors.green.shade800,
                                      title: "Training Rest",
                                      icon: Icons.play_circle_outline,
                                      onPress: () async {
                                        int? num = await showModalBottomSheet(
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
                                              spKey.trainingRest,
                                              num.toDouble());
                                          setState(() {
                                            trainingRest = num.toDouble();
                                          });
                                        }
                                      },
                                      trailing: isLoading
                                          ? CircularProgressIndicator()
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18, vertical: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.amber
                                                      .withOpacity(.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Text(
                                                "${trainingRest.toStringAsFixed(0)} Sec",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                    ),

                                    CustomTile(
                                      color: Colors.purple,
                                      icon: Icons.timer_outlined,
                                      title: "Countdown time",
                                      onPress: () async {
                                        int? num = await showModalBottomSheet(
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
                                              spKey.countdownTime,
                                              num.toDouble());
                                          setState(() {
                                            countdownTime = num.toDouble();
                                          });
                                        }
                                      },
                                      trailing: isLoading
                                          ? CircularProgressIndicator()
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18, vertical: 8),
                                              decoration: BoxDecoration(
                                                  color: Colors.red.shade600
                                                      .withOpacity(.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)),
                                              child: Text(
                                                "${countdownTime.toStringAsFixed(0)} Sec",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                    ),

                                    CustomTile(
                                      color: Colors.red,
                                      title: "Sound Setting",
                                      trailing: trailingIcon,
                                      icon: Icons.volume_up_outlined,
                                      onPress: () => Navigator.of(context)
                                          .pushNamed(SoundSetting.routeName),
                                    ),

                                    // CustomTile(
                                    //   title: "Visit Store",
                                    //   trailing: trailingIcon,
                                    //   icon: Icons.shopping_bag_outlined,
                                    //   onPress: () => Navigator.of(context).push(
                                    //       MaterialPageRoute(builder: (builder) {
                                    //     return StorePage();
                                    //   })),
                                    // ),
                                    //
                                  ],
                                ),
                              ),
                              getTitle("General Settings"),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  color: cardColor,
                                  child: Column(
                                    children: [
                                      CustomTile(
                                          color: Colors.pink,
                                          hasPadding: true,
                                          title:
                                              "Keep screen ${enable ? "On" : "Off"}",
                                          icon: Icons.lock_open_outlined,
                                          onPress: () {},
                                          trailing: Switch(
                                            value: enable,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            onChanged: (bool? value) {
                                              spHelper.saveBool(
                                                  spKey.awakeScreen, !enable);
                                              spHelper.saveInt(
                                                  spKey.initPage, 4);
                                              setState(() {
                                                enable = !enable;
                                              });
                                            },
                                          )),
                                      CustomTile(
                                          color: Colors.blue.shade900,
                                          icon: Icons.lightbulb_outline,
                                          title: "Theme Setting",
                                          onPress: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  ThemeSettingsPage(),
                                            );
                                          },
                                          trailing: trailingIcon),
                                      CustomTile(
                                          color: Colors.orange,
                                          icon: Icons.alarm_add_rounded,
                                          title: "Set reminder",
                                          onPress: () {
                                            Navigator.of(context).pushNamed(
                                                ReminderTab.routeName);
                                          },
                                          trailing: trailingIcon),
                                      if (subscriptionProvider.isProUser)
                                        CustomTile(
                                          color: Colors.orange.shade800,
                                          title: "Subscription Settings",
                                          trailing: trailingIcon,
                                          icon: Icons.subscriptions_outlined,
                                          onPress: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubscribedPage())),
                                        ),
                                      CustomTile(
                                          color: Colors.red.shade800,
                                          icon: Icons.restart_alt,
                                          title: "Reset Progress",
                                          trailing: trailingIcon,
                                          onPress: () async {
                                            bool isConnected =
                                                await connectivityProvider
                                                    .isNetworkConnected;
                                            showDialog(
                                                context: context,
                                                builder: (builder) {
                                                  return isConnected
                                                      ? ResetProgressDialog(
                                                          title:
                                                              "Rest Progress",
                                                          subtitle:
                                                              "After resetting process, all workout plan will restart from day 1 ",
                                                        )
                                                      : ConnectivityErrorDialog();
                                                });
                                          }),
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
                                        color: Colors.orange.shade800,
                                        title: "Test Voice",
                                        icon: Icons.volume_up_outlined,
                                        trailing: trailingIcon,
                                        onPress: () async {
                                          MediaHelper().readText(
                                              "Did you Hear the test voice");
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
                                      CustomTile(
                                        color: Colors.pink.shade800,
                                        title: "Device TTS Setting",
                                        icon: Icons.settings_outlined,
                                        trailing: trailingIcon,
                                        onPress: () async {
                                          try {
                                            AndroidIntent intent =
                                                AndroidIntent(
                                              action:
                                                  'com.android.settings.TTS_SETTINGS',
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
                                          color: Colors.red,
                                          icon: Icons.highlight_remove_outlined,
                                          title: "Remove Ads",
                                          trailing: trailingIcon,
                                          onPress: () async {
                                            bool isConnected =
                                                await connectivityProvider
                                                    .isNetworkConnected;
                                            if (isConnected) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          SubscriptionPage(
                                                            showCrossButton:
                                                                false,
                                                          )));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ConnectivityErrorDialog());
                                            }
                                          },
                                        ),
                                      if (!subscriptionProvider.isProUser)
                                        CustomTile(
                                          color: Colors.teal.shade800,
                                          icon: Icons.share_outlined,
                                          title: "Share With Friends",
                                          trailing: trailingIcon,
                                          onPress: () async {
                                            final String text =
                                                "I\'m training with Home Workout and am getting great results. \n\nHere are workouts for every muscle group to achieve your fitness goal. no equipment is needed. \n\nDownload the app : ${constants.playStoreLink}";

                                            await Share.share(
                                              text,
                                            );
                                          },
                                        ),
                                      CustomTile(
                                        color: Colors.blue.shade800,
                                        icon: Icons.chat_outlined,
                                        title: "Feedback",
                                        trailing: trailingIcon,
                                        onPress: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FeedbackPage()));
                                        },
                                      ),
                                      CustomTile(
                                        color: Colors.purple,
                                        icon: Icons.shopping_bag_outlined,
                                        title: "Our other apps",
                                        trailing: trailingIcon,
                                        onPress: () async {
                                          constants.openUrl(
                                              url:
                                                  "https://play.google.com/store/apps/dev?id=6652795005413832872");
                                        },
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
                                        color: Colors.amber.shade900,
                                        icon: Icons.email_outlined,
                                        title: "Contact us",
                                        trailing: trailingIcon,
                                        onPress: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ContactUsPage()));
                                        },
                                      ),
                                      CustomTile(
                                        color: Colors.purple,
                                        icon: FontAwesomeIcons.circleQuestion,
                                        title: "FAQ",
                                        onPress: () => Navigator.of(context)
                                            .pushNamed(FAQPage.routeName),
                                        trailing: trailingIcon,
                                      ),
                                      CustomTile(
                                        color: Colors.teal.shade800,
                                        icon: Icons.privacy_tip_outlined,
                                        title: "Privacy Policy",
                                        trailing: trailingIcon,
                                        onPress: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrivacyPolicy())),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              getTitle("Account"),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  color: cardColor,
                                  child: Column(
                                    children: [
                                      CustomTile(
                                        color: Colors.redAccent,
                                        icon: Icons.logout_outlined,
                                        title: "Logout",
                                        trailing: trailingIcon,
                                        onPress: () async {

                                           bool? res = await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("Log out"),
                                                  content: Text(
                                                      "Are you sure you want to Logout?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, true);
                                                        },
                                                        child: Text("Yes")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                        child: Text("No")),
                                                  ],
                                                );
                                              });

                                          if (res == null || res == false) {
                                            return;
                                          }

                                          if (res == true) {
                                            bool isConnected =
                                                await connectivityProvider
                                                    .isNetworkConnected;

                                            if (!isConnected) {
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) =>
                                                      ConnectivityErrorDialog());
                                              return;
                                            }

                                            showDialog(
                                                context: context,
                                                builder: (builder) {
                                                  return CustomLoadingIndicator(
                                                    msg: "Login out...",
                                                  );
                                                });

                                            var authProvider =
                                                Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false);

                                            await authProvider.logout(
                                                context: context);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                      CustomTile(
                                          color: Colors.red.shade800,
                                          icon: Icons.delete_outlined,
                                          title: "Delete Account",
                                          trailing: trailingIcon,
                                          onPress: () async {
                                            bool isConnected =
                                                await connectivityProvider
                                                    .isNetworkConnected;

                                            if (!isConnected) {
                                              showDialog(
                                                  context: context,
                                                  builder: (builder) =>
                                                      ConnectivityErrorDialog());
                                              return;
                                            }
                                            bool? res = await showDialog(
                                                context: context,
                                                builder: (builder) {
                                                  return DeleteAccountDialog();
                                                });

                                            if (res == null || res == false) {
                                              return;
                                            }

                                            showDialog(
                                                context: context,
                                                builder: (builder) {
                                                  return CustomLoadingIndicator(
                                                    msg: "Loading",
                                                  );
                                                });
                                            var authProvider =
                                                Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false);
                                            await authProvider.deleteAccount(
                                                context: context);
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              SocialIcons(),
                              SizedBox(
                                height: 40,
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
                                            constants.versionNumber,
                                        //  + " (beta)".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            letterSpacing: 1.2,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!
                                                .withOpacity(.7),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            }),
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
    Constants constants = Constants();
    buildIcon({required String imgScr, required Function onTap}) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(imgScr),
        ),
      );
    }

    return Column(
      children: [
        Text("Follow us"),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildIcon(
                imgScr: "https://cdn-icons-png.flaticon.com/512/174/174855.png",
                onTap: () {
                  constants.openUrl(
                      url: "https://www.instagram.com/beast._.fitness");
                }),
            SizedBox(
              width: 22,
            ),
            buildIcon(
                imgScr: "https://cdn-icons-png.flaticon.com/512/174/174848.png",
                onTap: () {
                  constants.openUrl(
                      url:
                          "https://www.facebook.com/profile.php?id=100093072879042");
                }),
            SizedBox(
              width: 22,
            ),
            buildIcon(
                imgScr: "https://cdn-icons-png.flaticon.com/512/174/174857.png",
                onTap: () {
                  constants.openUrl(
                      url: "https://www.linkedin.com/company/feet-and-flex");
                }),
          ],
        ),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final Function onPress;
  bool? hasPadding;
  final Color color;

  CustomTile(
      {required this.title,
      required this.icon,
      required this.trailing,
      required this.onPress,
      this.hasPadding,
      required this.color});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 10, bottom: 10, left: 16, right: hasPadding == null ? 16 : 0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color.withOpacity(isDark ? .4 : .2)),
              child: Icon(
                icon,
                size: 22,
                color: isDark
                    ? Colors.white.withOpacity(.7)
                    : Colors.black.withOpacity(.8),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? Colors.white.withOpacity(.8)
                      : Colors.black.withOpacity(.8)),
            ),
            Spacer(),
            trailing
          ],
        ),
      ),
    );
  }
}
