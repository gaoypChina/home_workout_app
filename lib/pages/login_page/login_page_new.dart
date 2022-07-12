import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:full_workout/pages/main/setting_page/privacy_policy.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/backup_provider.dart';
import '../../widgets/loading_indicator.dart';
import '../detail_input_page/detail_input_page.dart';
import '../main_page.dart';

class LoginSplashPage extends StatefulWidget {
  @override
  _LoginSplashPageState createState() => _LoginSplashPageState();
}

class _LoginSplashPageState extends State<LoginSplashPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;

    getLoginButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
        child: ElevatedButton(
          onPressed: () async {
            try {
              log("cp 1");
              showDialog(
                  context: context,
                  builder: (builder) => CustomLoadingIndicator(msg: "Loading"));
              await authProvider.googleLogin(context: context);
              var user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                bool userExist =
                    await authProvider.isUserExist(context: context, user: user);
                if (userExist) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MainPage(index: 0);
                  }));
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailInputPage();
                  }));
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return DetailInputPage();
                  }));
                }
              }
            } catch (e) {
              log(e.toString());
            } finally {
              Navigator.of(context).pop();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  height: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: Image.asset(
                          "packages/flutter_signin_button/assets/logos/2.0x/google_light.png"))),
              Spacer(),
              Text("Continue with Google"),
              Spacer(),
              Icon(Icons.navigate_next_outlined)
            ],
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              minimumSize: Size(width * 0, 50)),
        ),
      );
    }

    getFooter() {
      return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By Click continue, you are agree to our ",
                    style:TextStyle( height: 1.3, fontSize: 13,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8)),
                    children: [
                      WidgetSpan(
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>PrivacyPolicy()));
                            },
                        child: Text(
                          "Terms and conditions.",
                          style: TextStyle(height: 1.3,
                            color: Colors.blue,fontSize: 13
                          ),
                        ),
                      ))
                    ])),
          ));
    }

    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80,),
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Home ".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 32)),
                TextSpan(
                    text: "Workout".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                        //     color: Theme.of(context).primaryColor,
                        fontSize: 32)),
              ])),
          SizedBox(
            height: 12,
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
          //   child: Text(
          //     "The purpose of workout is to tighten up the slack, toughen the body, and polish the spirit.",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         letterSpacing: 1,
          //         height: 1.3,
          //         fontWeight:FontWeight.w400 ,
          //         color: Theme.of(context)
          //             .textTheme
          //             .bodyText1!
          //             .color!
          //             .withOpacity(.8)),
          //   ),
          // ),


          // ClipPath(
          //   clipper: OvalBottomBorderClipper(),
          //   child: Container(
          //     height: width,
          //     width: width,
          //     color: Colors.blue,
          //     child: Column(
          //       children: [
          //         Container(
          //           height: 21.1,
          //           color: Colors.white.withOpacity(isDark ? .75 : .9),
          //         ),
          //         Opacity(
          //           opacity: isDark ? .75 : .9,
          //           child: Image.asset(
          //             "assets/other/login_cover.jpg",
          //             height: width - 51,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         Container(
          //           height: 29.9,
          //           color: Colors.white.withOpacity(isDark ? .75 : .9),
          //         )
          //       ],
          //     ),
          //   ),
          // ),

          Spacer(),

          getLoginButton(),



          SizedBox(
            height: 8,
          ),
          //  getMobileNumberButton(false),
        // getLoginButton(),
          getFooter(),
        ],
      ),
    );
  }
}
