import 'package:flutter/material.dart';
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
    Color titleBgColor = Color(0xffF6F6F6);
    Color titleColor = Color(0xffA9A9A9);
    Color leadingIconColor = Color(0xff969696);

    var textStyle =textTheme.subtitle1.copyWith(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: titleColor);
    var contentTextStyle = textTheme.subtitle2.copyWith(fontSize: 15);
   Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Settings",style: TextStyle(color: Colors.black),),
        titleSpacing: 24,
        elevation: 0,automaticallyImplyLeading: false,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.person_rounded,color: Colors.blue,)),
        )],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: titleBgColor,
            width: width,
            padding: const EdgeInsets.only(left: 24.0,top: 8,bottom: 8),
            child: Text(
              "Workout".toUpperCase(),
              style: textStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8,right: 8),
            child: Expanded(
              // height: 225,
              child: Column(
                children: [
                  ListTile(
                    minLeadingWidth: 1,
                    leading: Icon(Icons.person,color: leadingIconColor,),
                    title: Text("Edit Profile",style: contentTextStyle),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProfileSettingScreen.routeName);
                    },
                    trailing: trailingIcon,
                  ),

                  ListTile(
                    minLeadingWidth: 1,

                    leading: Icon(Icons.local_activity_outlined,color: leadingIconColor,),
                    title: Text("Training Settings",style: contentTextStyle),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(TrainingSettingsScreen.routeName);
                    },
                    trailing: trailingIcon,

                  ),

                  ListTile(
                    minLeadingWidth: 1,
                    leading: Icon(Icons.volume_up,color: leadingIconColor,),
                    title: Text("Sound",style: contentTextStyle),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SoundSetting.routeName);
                    },
                    trailing: trailingIcon,

                  ),
                ],
              ),
            ),
          ),
           Container(
              color: titleBgColor,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24,top: 8,bottom: 8),
                child:Text(
                "Personalised".toUpperCase(),
                style: textStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8,right: 0),
            child: Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.toggle_off_outlined,color: leadingIconColor,),
                    title: Text("Keep screen on",style: contentTextStyle,),
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

                  ListTile(
                    leading: Icon(Icons.timer,color: leadingIconColor,),
                    title: Text("Set reminder",style: contentTextStyle,),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ReminderTab.routeName);
                    },
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: trailingIcon,
                    ),
                  ),
                ],
              ),
            ),
          ),
         Container(
           width: width,
              color: titleBgColor,
              child:  Padding(
                padding: const EdgeInsets.only(left:24.0,right: 24,top: 8,bottom: 8),
                child: Text(
                "Other".toUpperCase(),
                style: textStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8,right:8 ),
            child: Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.share,color: leadingIconColor,),
                    title: Text("Share With Friends",style: contentTextStyle,),
                    trailing: trailingIcon,
                    onTap: () async {
                      final RenderBox box = context.findRenderObject();
                      final String text = "my app link";
                      await Share.share(text,
                          subject: "",
                          sharePositionOrigin:
                              box.globalToLocal(Offset.zero) & box.size);
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.email,color: leadingIconColor,),
                    title: Text("Contact Us",style: contentTextStyle,),
                    trailing: trailingIcon,

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

                  ListTile(
                    leading: Icon(Icons.star,color: leadingIconColor,),
                    title: Text("5 star Ratting",style: contentTextStyle,),
                    trailing: trailingIcon,

                  ),


                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined,color: leadingIconColor,),
                    title: Text("Privacy Policy",style: contentTextStyle,),
                    trailing: trailingIcon,

                    onTap:()  =>Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy())),
                  ),
                ],
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
