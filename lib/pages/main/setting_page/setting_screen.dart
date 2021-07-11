import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_tab.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/setting_page/training_settings_screen.dart';
import 'package:share/share.dart';
import 'package:wakelock/wakelock.dart';
import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  static const routeName = "setting-page";



  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
bool enable = true;

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    Color titleColor = Color(0xffA9A9A9);

    var textStyle = textTheme.subtitle1.copyWith(
        wordSpacing: 4,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: titleColor);
    Icon trailingIcon = Icon(
      Icons.arrow_forward_ios,
      color: Colors.black,
      size: 16,
    );

    return Scaffold(
 
      appBar: AppBar(
        backgroundColor: constants.appBarColor,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        titleSpacing: 24,
        elevation: 5,
        automaticallyImplyLeading: false,
        actions: [


       IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                )),

          IconButton(
            onPressed: (){

            },
            icon: Icon(FontAwesome.question_circle_o),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Workout".toUpperCase(),
                style: textStyle,
              ),
              SizedBox(height: 8,),
              CustomTile(
                icon: Icons.person,
                title: "Edit Profile",
                trailing: trailingIcon,
                onPress: () => Navigator.of(context)
                    .pushNamed(ProfileSettingScreen.routeName),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTile(
                icon: Icons.local_activity_outlined,
                trailing: trailingIcon,
                title: "Training Settings",
                onPress: () => Navigator.of(context)
                    .pushNamed(TrainingSettingsScreen.routeName),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTile(
                title: "Sound",
                trailing: trailingIcon,
                icon: Icons.volume_up,
                onPress: () =>
                    Navigator.of(context).pushNamed(SoundSetting.routeName),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Personalised".toUpperCase(),
                style: textStyle,
              ),
              SizedBox(height: 8,),
              CustomTile(
                icon: Icons.toggle_off_outlined,
                title: "Keep screen on",
                onPress: () {},
                trailing: Switch(
                  activeColor: Colors.blue,
                  value: enable,
                  onChanged: (value) {
                    setState(() {
                      enable = value;
                    });
                    Wakelock.toggle(enable: value);
                  },
                ),
                //  onTap: () {},
              ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 20,
              ),
              Text(
                "Other".toUpperCase(),
                style: textStyle,
              ),
              SizedBox(height: 8,),
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
              SizedBox(
                height: 10,
              ),
              CustomTile(
                icon: Icons.email,
                title: "Contact Us",
                trailing: trailingIcon,
                onPress: () async {
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

                  final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'workoutfeedback@gmail.com',
                      queryParameters: {
                        'subject': '${androidInfo.product}',
                      });
                  await launch(_emailLaunchUri.toString());

                  print(
                      'Running on ${androidInfo.androidId}'); // e.g. "Moto G (4)"

                  // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                  // print('Running on ${iosInfo.utsname.machine}');  //
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTile(
                icon: Icons.star,
                title: "5 star Ratting",
                trailing: trailingIcon,
                onPress: () {},
              ),
              SizedBox(
                height: 10,
              ),
              CustomTile(
                icon: Icons.privacy_tip_outlined,
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
                    style: textStyle.copyWith(fontSize: 20),
                  ),
                ),
              ),

            ],
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

    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(12)) ),
      child: ListTile(

          tileColor: constants.tileColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          leading: CircleAvatar(
            child: Icon(icon),
          ),
          onTap: onPress,
          title: Text(
            title,
            style: constants.contentTextStyle.copyWith(fontSize: 16),
          ),
          trailing: trailing),
    );
  }
}


// SizedBox(height: 200,),
// Container(
// color: titleBgColor,
// width: width,
// padding: const EdgeInsets.only(left: 24.0, top: 8, bottom: 8),
// child: Text(
// "Workout".toUpperCase(),
// style: textStyle,
// ),
// ),
// Padding(
// padding: EdgeInsets.only(left: 8, right: 8),
// child: Expanded(
// // height: 225,
// child: Column(
// children: [
// ListTile(
// minLeadingWidth: 1,
// leading: Icon(
// Icons.person,
// color: leadingIconColor,
// ),
// title: Text("Edit Profile", style: contentTextStyle),
// onTap: () {
// Navigator.of(context)
//     .pushNamed(ProfileSettingScreen.routeName);
// },
// trailing: trailingIcon,
// ),
// ListTile(
// minLeadingWidth: 1,
// leading: Icon(
// Icons.local_activity_outlined,
// color: leadingIconColor,
// ),
// title:
// Text("Training Settings", style: contentTextStyle),
// onTap: () {
// Navigator.of(context)
//     .pushNamed(TrainingSettingsScreen.routeName);
// },
// trailing: trailingIcon,
// ),
// ListTile(
// minLeadingWidth: 1,
// leading: Icon(
// Icons.volume_up,
// color: leadingIconColor,
// ),
// title: Text("Sound", style: contentTextStyle),
// onTap: () {
// Navigator.of(context)
//     .pushNamed(SoundSetting.routeName);
// },
// trailing: trailingIcon,
// ),
// ],
// ),
// ),
// ),
// Container(
// color: titleBgColor,
// width: width,
// child: Padding(
// padding: const EdgeInsets.only(
// left: 24.0, right: 24, top: 8, bottom: 8),
// child: Text(
// "Personalised".toUpperCase(),
// style: textStyle,
// ),
// ),
// ),
// Padding(
// padding: EdgeInsets.only(left: 8, right: 0),
// child: Expanded(
// child: Column(
// children: [
// ListTile(
// leading: Icon(
// Icons.toggle_off_outlined,
// color: leadingIconColor,
// ),
// title: Text(
// "Keep screen on",
// style: contentTextStyle,
// ),
// trailing: Switch(
// activeColor: Colors.blue,
// value: enable,
// onChanged: (value) {
// setState(() {
// enable = value;
// });
// Wakelock.toggle(enable: value);
// },
// ),
// //  onTap: () {},
// ),
// ListTile(
// leading: Icon(
// Icons.timer,
// color: leadingIconColor,
// ),
// title: Text(
// "Set reminder",
// style: contentTextStyle,
// ),
// onTap: () {
// Navigator.of(context)
//     .pushNamed(ReminderTab.routeName);
// },
// trailing: Padding(
// padding: const EdgeInsets.only(right: 8.0),
// child: trailingIcon,
// ),
// ),
// ],
// ),
// ),
// ),
// Container(
// width: width,
// color: titleBgColor,
// child: Padding(
// padding: const EdgeInsets.only(
// left: 24.0, right: 24, top: 8, bottom: 8),
// child: Text(
// "Other".toUpperCase(),
// style: textStyle,
// ),
// ),
// ),
// Padding(
// padding: EdgeInsets.only(left: 8, right: 8),
// child: Expanded(
// child: Column(
// children: [
// ListTile(
// leading: Icon(
// Icons.share,
// color: leadingIconColor,
// ),
// title: Text(
// "Share With Friends",
// style: contentTextStyle,
// ),
// trailing: trailingIcon,
// onTap: () async {
// final RenderBox box = context.findRenderObject();
// final String text = "my app link";
// await Share.share(text,
// subject: "",
// sharePositionOrigin:
// box.globalToLocal(Offset.zero) & box.size);
// },
// ),
// ListTile(
// leading: Icon(
// Icons.email,
// color: leadingIconColor,
// ),
// title: Text(
// "Contact Us",
// style: contentTextStyle,
// ),
// trailing: trailingIcon,
// onTap: () async {
// DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo =
//     await deviceInfo.androidInfo;
//
// final Uri _emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: 'workoutfeedback@gmail.com',
//     queryParameters: {
//       'subject': '${androidInfo.product}',
//     });
// await launch(_emailLaunchUri.toString());
//
// print(
// 'Running on ${androidInfo.androidId}'); // e.g. "Moto G (4)"
//
// // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
// // print('Running on ${iosInfo.utsname.machine}');  //
// },
// ),
// ListTile(
// leading: Icon(
// Icons.star,
// color: leadingIconColor,
// ),
// title: Text(
// "5 star Ratting",
// style: contentTextStyle,
// ),
// trailing: trailingIcon,
// ),
// ListTile(
// leading: Icon(
// Icons.privacy_tip_outlined,
// color: leadingIconColor,
// ),
// title: Text(
// "Privacy Policy",
// style: contentTextStyle,
// ),
// trailing: trailingIcon,
// onTap: () => Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => PrivacyPolicy())),
// ),
// ],
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(12.0),
// child: Center(
// child: Text(
// "Version 1.0.0",
// style: textStyle.copyWith(fontSize: 20),
// ),
// ),
// ),
// SizedBox(
// height: 0,
// ),