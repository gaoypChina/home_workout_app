import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/navigation/navigation_service.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'onboarding_page.dart';

class LoginSplashPage extends StatefulWidget {
  @override
  _LoginSplashPageState createState() => _LoginSplashPageState();
}

class _LoginSplashPageState extends State<LoginSplashPage>
    with TickerProviderStateMixin {
  // final NavigationService _navigationService = GetIt.instance.get();

  getMobileNumberButton(bool isDark) {
    return Container(

      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(left: 25, right: 25, top: 10,bottom: 10),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
            side: BorderSide(
                color: Colors.blue, style: BorderStyle.solid, width: 1),
          ),

          onPressed: () {
            //_navigationService.navigate("/sendOtp");
          },
          child: Text(
            "Continue With Email",
            style: Theme.of(context)
                .textTheme
                .button
                .merge(TextStyle(color: Colors.blue)),
          )),
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
                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                      height: 1.5,
                      color: Constants.secondaryTextColor,
                      fontSize: 13)),
                  children: [
                    TextSpan(
                        text: "Terms and conditions.",
                        style: Theme.of(context).textTheme.subtitle2.merge(
                            TextStyle(
                                color: Constants.primaryColor, fontSize: 13)))
                  ])),
        ));
  }

  getSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(

        child: Row(
          children: [
            Container(
              width: 140,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                    side: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid, width: 1),
                  ),
                  onPressed: () {
                    //_navigationService.navigate("/sendOtp");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Icon(FontAwesome.google,color: Colors.white,),

                      Text(
                        "Google",
                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(height: 1.4, fontSize: 15, color: Colors.white)))
                    ],
                  )),
            ),
            Spacer(),
            Container(
              width: 140,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                    side: BorderSide(
                        color: Colors.blue, style: BorderStyle.solid, width: 1),
                  ),
                  onPressed: () {
                    //_navigationService.navigate("/sendOtp");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Icon(FontAwesome.facebook,color: Colors.white,),

                      Text(
                        "Facebook",
                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(height: 1.4, fontSize: 15, color: Colors.white),)
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getIt.unregister<SocketManager>();
  //   getIt.registerLazySingleton(() => SocketManager());
  // }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Text(
            "Home Workout",
            style: Theme.of(context).textTheme.headline3.merge(TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 36)),
          ),
          Expanded(
            child: OnBoardingPage(),
          ),
          SizedBox(
            height: 18,
          ),
          getSignUp(),

          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width*.125,),
              Container(height: .25,color: Colors.grey,width: MediaQuery.of(context).size.width*.3,),
              SizedBox(width: MediaQuery.of(context).size.width*.025,),
              Center(child: Card(child: Text("OR",style: TextStyle(color: Colors.grey),),color: Colors.black54,elevation: 10,),),
              SizedBox(width: MediaQuery.of(context).size.width*.025,),
              Container(height: .25,color: Colors.grey,width: MediaQuery.of(context).size.width*.3,),
              SizedBox(width: MediaQuery.of(context).size.width*.125,),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          getMobileNumberButton(isDark),

        ],
      ),
    );
  }
} //1e88e5
