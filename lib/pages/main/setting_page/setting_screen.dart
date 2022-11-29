
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
import '../../../widgets/dialogs/connectivity_error_dialog.dart';
import '../../../widgets/loading_indicator.dart';
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
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    double height = MediaQuery.of(context).size.height;

    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      size: 16,
      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
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
          padding: const EdgeInsets.only(left: 16.0, top: 20, bottom: 16),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                wordSpacing: 4,
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
                color: isDark ? null : Colors.black.withOpacity(.7)),
          ));
    }

    getDivider() {
      return Container(
        color: Colors.grey.shade500.withOpacity(.15),
        height: .5,
      );
    }

    Color cardColor = Theme.of(context).scaffoldBackgroundColor;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<BackupProvider>(builder: (context, backupProvider, _) {
            return WillPopScope(
                onWillPop: () => widget.onBack(),
                child: Scaffold(
                  backgroundColor: isDark
                      ? Theme.of(context).cardColor.withOpacity(.6)
                      : Colors.blueGrey.shade300.withOpacity(.1),
                  body: NestedScrollView(

                    controller: _scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                       
                          automaticallyImplyLeading: false,
                          title: Row(
                            children: [
                              Text(
                                isShrink ? name : "",
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : isShrink
                                          ? Colors.black
                                          : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          elevation: .5,
                          centerTitle: false,
                          expandedHeight: height * .16,
                          collapsedHeight: 60,
                          pinned: true,
                          floating: false,
                          forceElevated: innerBoxIsScrolled,
                          flexibleSpace: FlexibleSpaceBar(
                              background: BackupDataCard(
                            lastSync: lastSync,
                            name: name,
                            onSync: ()
                            async {
                              bool isConnected =
                                  await connectivityProvider.isNetworkConnected;

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
                          )),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      physics: isShrink ? BouncingScrollPhysics() : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTitle("Workout"),
                          Container(
                            color: cardColor,
                            child: Column(
                              children: [
                                getDivider(),
                                CustomTile(
                                  icon: Icons.person_outline_sharp,
                                  title: "Edit Profile",
                                  trailing: trailingIcon,
                                  onPress: () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ProfileSettingPage()));
                                    name =
                                        await spHelper.loadString(spKey.name) ??
                                            "User";
                                    setState(() {});
                                  },
                                ),
                                getDivider(),
                                CustomTile(
                                  title: "Training Rest",
                                  icon: CupertinoIcons.time,
                                  onPress: () async {
                                    int? num =
                                        await showMaterialModalBottomSheet(
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
                                          trainingRest.toStringAsFixed(0) +
                                              " Sec",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                ),
                                getDivider(),
                                CustomTile(
                                  icon: Icons.timer_outlined,
                                  title: "Countdown time",
                                  onPress: () async {
                                    int? num =
                                        await showMaterialModalBottomSheet(
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
                                          countdownTime.toStringAsFixed(0) +
                                              " Sec",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                getDivider(),
                              ],
                            ),
                          ),
                          if (!subscriptionProvider.isProUser)
                            buildPrimeButton(),
                          getTitle("General Settings"),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            child: Container(
                              color: cardColor,
                              child: Column(
                                children: [
                                  getDivider(),
                                  isLoading
                                      ? CustomTile(
                                          title: "Keep screen",
                                          icon: Icons.toggle_off_outlined,
                                          trailing: CircularProgressIndicator(),
                                          onPress: () {},
                                        )
                                      : SwitchListTile(
                                          contentPadding: EdgeInsets.only(
                                              left: 18, right: 2),
                                          value: enable,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          onChanged: (value) {
                                            spHelper.saveBool(
                                                spKey.awakeScreen, value);
                                            spHelper.saveInt(spKey.initPage, 4);
                                            setState(() {
                                              enable = value;
                                            });
                                          },
                                          secondary: Icon(
                                            Icons.toggle_on_outlined,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color,
                                          ),
                                          title: Text(
                                            "Keep screen ${enable ? "On" : "Off"}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                            ),
                                          ),
                                        ),
                                  getDivider(),
                                  CustomTile(
                                      icon: Icons.lightbulb_outline,
                                      title: "Theme Setting",
                                      onPress: () {
                                        showMaterialModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              ThemeSettingsPage(),
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
                                  if (subscriptionProvider.isProUser)
                                    getDivider(),
                                  if (subscriptionProvider.isProUser)
                                    CustomTile(
                                      title: "Subscription Settings",
                                      trailing: trailingIcon,
                                      icon: Icons.subscriptions_outlined,
                                      onPress: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SubscribedPage())),
                                    ),
                                  getDivider(),
                                  CustomTile(
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
                                                      title: "Rest Progress",
                                                      subtitle:
                                                          "After resetting process, all workout plan will restart from day 1 ",
                                                    )
                                                  : ConnectivityErrorDialog();
                                            });
                                      }),
                                  getDivider(),
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
                                  getDivider(),
                                  CustomTile(
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
                                  getDivider(),
                                  CustomTile(
                                    title: "Device TTS Setting",
                                    icon: Icons.settings_outlined,
                                    trailing: trailingIcon,
                                    onPress: () async {
                                      try {
                                        AndroidIntent intent = AndroidIntent(
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
                                  getDivider(),
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
                                  getDivider(),
                                  if (!subscriptionProvider.isProUser)
                                    CustomTile(
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
                                                      SubscriptionPage()));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ConnectivityErrorDialog());
                                        }
                                      },
                                    ),
                                  if (!subscriptionProvider.isProUser)
                                    getDivider(),
                                  CustomTile(
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
                                  getDivider(),
                                  RateAppInitWidget(
                                    builder: (rateMyApp) => RateDialogPage(
                                      rateMyApp: rateMyApp,
                                    ),
                                  ),
                                  getDivider(),
                                  CustomTile(
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
                                  getDivider(),
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
                                  getDivider(),
                                  CustomTile(
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
                                  getDivider(),
                                  CustomTile(
                                    icon: FontAwesomeIcons.questionCircle,
                                    title: "FAQ",
                                    onPress: () => Navigator.of(context)
                                        .pushNamed(FAQPage.routeName),
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
                                            builder: (context) =>
                                                PrivacyPolicy())),
                                  ),
                                  getDivider(),
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
                                  getDivider(),
                                  CustomTile(
                                    icon: Icons.logout_outlined,
                                    title: "Logout",
                                    trailing: trailingIcon,
                                    onPress: () async {
                                      bool? res = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  Text("Log out"),
                                              content:  Text("Are you sure you want to Logout?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context, true);
                                                    },
                                                    child: Text("Yes")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context, false);
                                                    },
                                                    child: Text("No")),
                                              ],
                                            );
                                          });

                                      if(res == null || res == false)
                                        return;
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
                                            Provider.of<AuthProvider>(context,
                                                listen: false);
                                        await authProvider.logout(
                                            context: context);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  getDivider(),
                                  CustomTile(
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
                                            Provider.of<AuthProvider>(context,
                                                listen: false);
                                        await authProvider.deleteAccount(
                                            context: context);
                                        Navigator.of(context).pop();
                                      }),
                                  getDivider(),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 40,
                          // ),
                          // SocialIcons(),
                          SizedBox(
                            height: 30,
                          ),

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
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          });
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
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return ListTile(
      contentPadding: EdgeInsets.only(left: 18, right: 14, top: 2, bottom: 2),
      leading: Icon(
        icon,
        color: Theme.of(context)
            .textTheme
            .bodyText1!
            .color
      ),
      onTap: () => onPress(),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
      trailing: Padding(padding: EdgeInsets.only(right: 4), child: trailing),
    );
  }
}
