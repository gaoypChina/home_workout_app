import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_screen.dart';
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
  var textStyle = TextStyle(fontWeight: FontWeight.w800, fontSize: 20);
  bool enable = true;


  @override
  Widget build(BuildContext context) {
    double thickness = 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0,
        leading: FlatButton(
          child: Icon(
            Icons.keyboard_backspace_sharp,
            color: Colors.white,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Workout",
              style: textStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Expanded(
              // height: 225,
              child: Card(
                color: Colors.blue.withOpacity(.7),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_pin),
                      title: Text("Edit Profile"),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ProfileSettingScreen.routeName);
                      },
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.local_activity_outlined),
                      title: Text("Training Settings"),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(TrainingSettingsScreen.routeName);
                      },
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.volume_down),
                      title: Text("Sound"),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(SoundSettingsScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Personalised",
              style: textStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Expanded(
              // height: 225,
              child: Card(
                color: Colors.blue.withOpacity(.7),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.toggle_off_outlined),
                      title: Text("Keep screen on"),
                      trailing: Switch(
                        activeColor: Colors.amber,
                        value: enable,
                        onChanged: (value) {
                          setState(() {
                            enable = value;
                          });
                          Wakelock.toggle(enable: value);
                        },
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text("Language options"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Other",
              style: textStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Expanded(
              // height: 225,
              child: Card(
                color: Colors.blue.withOpacity(.7),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text("Share With Friends"),
                      onTap: () async {
                        final RenderBox box = context.findRenderObject();
                        final String text = "my app link";
                        await Share.share(text,
                            subject: "",
                            sharePositionOrigin:
                                box.globalToLocal(Offset.zero) & box.size);
                      },
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text("Contact Us"),
                      onTap: ()async{
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

                       final Uri _emailLaunchUri = Uri(
                         scheme: 'mailto',
                         path: 'workoutfeedback@gmail.com',
                         queryParameters: {
                           'subject':'${androidInfo.product}',
                         }
                       );
                     await  launch(_emailLaunchUri.toString());

                        print('Running on ${androidInfo.androidId}');  // e.g. "Moto G (4)"

                        // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                        // print('Running on ${iosInfo.utsname.machine}');  //
                      },
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text("5 star Ratting"),
                    ),
                    Divider(
                      thickness: thickness,
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip_outlined),
                      title: Text("Privacy Policy"),
                      onTap:()  =>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicy())),
                    ),
                  ],
                ),
              ),
            ),
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
          SizedBox(
            height: 0,
          ),
        ],
      )),
    );
  }
}
