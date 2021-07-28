import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/pages/main/home_page/leading_widget.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_tab.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:full_workout/pages/services/faq_page.dart';
import 'package:share/share.dart';
import 'package:wakelock/wakelock.dart';
import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';

class SettingPage extends StatefulWidget {
  static const routeName = "setting-page";

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  bool enable = true;

  getScreenEnable() async {
    enable = await spHelper.loadBool(spKey.awakeScreen) ?? true;
    setState(() {});
  }

  @override
  void initState() {
    spHelper.saveInt(spKey.initPage, 0);
    getScreenEnable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
      size: 16,
    );

    getTitle(String text) {
      return Container(
          color: Colors.grey.shade50,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Text(
            text,
            style: textTheme.subtitle1.copyWith(
                wordSpacing: 4,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.blue.shade900),
          ));
    }

    return Scaffold(
      backgroundColor: Colors.white70,

      body: NestedScrollView(
          controller: ScrollController(),
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,),
                actions: getLeading(context),
                backgroundColor: constants.appBarColor,
                automaticallyImplyLeading: false,
                expandedHeight: 150.0,
                pinned: true,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Settings",style: TextStyle(color: constants.appBarContentColor),),
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
                  icon: Icons.person,
                  title: "Edit Profile",
                  trailing: trailingIcon,
                  onPress: () => Navigator.of(context)
                      .pushNamed(ProfileSettingScreen.routeName),
                ),
                CustomTile(
                  icon: Icons.local_activity_outlined,
                  trailing: trailingIcon,
                  title: "Training Settings",
                  onPress: () => Navigator.of(context)
                      .pushNamed(TrainingSettingsScreen.routeName),
                ),
                CustomTile(
                  title: "Sound",
                  trailing: trailingIcon,
                  icon: Icons.volume_up,
                  onPress: () =>
                      Navigator.of(context).pushNamed(SoundSetting.routeName),
                ),
                getTitle("Personalised"),
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  value: enable,
                  onChanged: (value) {
                    spHelper.saveBool(spKey.awakeScreen, value);
                    spHelper.saveInt(spKey.initPage, 4);
                    setState(() {
                      enable = value;
                    });
                    Phoenix.rebirth(context);
                  },
                  secondary: CircleAvatar(
                    child: Icon(
                      Icons.toggle_off_outlined,
                    ),
                  ),
                  title: Text(
                    "Keep screen ${enable ? "On" : "Off"}",
                    style: constants.contentTextStyle.copyWith(fontSize: 16),
                  ),
                  //  onTap: () {},
                ),
                CustomTile(
                  icon: Icons.timer,
                  title: "Set reminder",
                  onPress: () {
                    Navigator.of(context).pushNamed(ReminderTab.routeName);
                  },
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: trailingIcon,
                  ),
                ),
                getTitle("Support Us"),
                CustomTile(
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
                  icon: Icons.star,
                  title: "5 star Ratting",
                  trailing: trailingIcon,
                  onPress: () {},
                ),
                getTitle("About us"),
                CustomTile(
                  icon: Icons.email,
                  title: "Feedback",
                  trailing: trailingIcon,
                  onPress: () async {
                    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                    AndroidDeviceInfo info = await deviceInfo.androidInfo;
                    Map toSend = {
                      "version": info.version.release.toString(),
                      "brand": info.brand.toString(),
                      "device": info.device.toString(),
                      "display": info.display.toString()
                    };

                    final Uri _emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'workoutfeedback@gmail.com',
                        queryParameters: {
                          'subject': '${toSend.toString()}',
                        });
                    await launch(_emailLaunchUri.toString());

                    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                    // print('Running on ${iosInfo.utsname.machine}');  //
                  },
                ),
                CustomTile(
                  icon: FontAwesome.question_circle,
                  title: "FAQ",
                  onPress: () =>
                      Navigator.of(context).pushNamed(FAQPage.routeName),
                  trailing: trailingIcon,
                ),
                CustomTile(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  trailing: trailingIcon,
                  onPress: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      "Version 1.0.0",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget trailing;
  final Function onPress;

  CustomTile({this.title, this.icon, this.trailing, this.onPress});

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ListTile(
          minLeadingWidth: 18,
          contentPadding: EdgeInsets.only(left: 8, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          leading: CircleAvatar(
              child: Icon(icon)),
          onTap: onPress,
          title: Text(
            title,
            style: constants.contentTextStyle.copyWith(fontSize: 16),
          ),
          trailing: trailing),
    );
  }
}


