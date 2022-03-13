import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'main_page.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "login-page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    goToNextPage(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return MainPage(index: 0,);
      }));
    }

    return Scaffold(

        body: Column(
      children: [
ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Container(
              height: width*1,
              width: width,
              child: Opacity(
                opacity: .7,
                child: Image.network(
                  "https://images.pexels.com/photos/4498606/pexels-photo-4498606.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  // "https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aG9tZSUyMHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.cover,

                ),
              ),
            ),
          ),

        SizedBox(
          height: 28,
        ),
      //  Image.asset("assets/app_icon.png",height: 80,),
        SizedBox(
          height: 18,
        ),
        Text(
          "Welcome".toUpperCase(),
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Login to continue",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
              letterSpacing: 1.8),
        ),
        Spacer(),
        Container(
          color: Colors.blue,
          height: 50,
          width: width * .85,
          child: SignInButton(
            Buttons.Google,
            text: "Continue with Google",
            onPressed: goToNextPage,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: width * .85,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xff4267B2)),
            child: Row(
              children: [
                Spacer(),
                FaIcon(FontAwesomeIcons.facebookSquare),
                SizedBox(
                  width: 12,
                ),
                Text("Continue with Facebook"),
                Spacer(),
              ],
            ),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 28,
        ),




      ],
    ));
  }
}
