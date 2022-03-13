import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/constants/constant.dart';

import '../main_page.dart';


class QuitPage extends StatefulWidget {
  @override
  _QuitPageState createState() => _QuitPageState();
}

class _QuitPageState extends State<QuitPage> {
  Constants constants = Constants();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    getButton(
        {required Function onPress,
          required String title,
          required Color textColor,
          required Color backgroundColor}) {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backgroundColor,
              side: BorderSide(
                  color: Colors.blue.shade700,
                  style: BorderStyle.solid,
                  width: 2),
            ),
            onPressed: () {
              onPress();
              setState(() {});
            },
            child: Text(
              title,
              style: TextStyle(
                  color:textColor, fontSize: title == "Quit" ? 18 : 14),
            )),
      );
    }

    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    Color defaultTextColor = Colors.blue.shade700;
    Color defaultBackgroundColor = isDark?Colors.black:Colors.white;

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(


        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: () async {
               Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(index: 0,)));
            },
            icon: Icon(
              Icons.sentiment_dissatisfied_sharp,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              "Quit Workout",
              style: TextStyle(
                  fontSize: 16, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all( 12.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Icon(Icons.arrow_back),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade700,
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .3,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      "assets/other/rest.svg",
                    ),
                  ),
                  Spacer(),


                  Text(
                    "Quit",
                    style: TextStyle(
                        color: isDark?Colors.white:Colors.black,
                        fontSize: 40,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Please tell us what stopped you, so we can make your next workout perfect",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                 Spacer(),
                  getButton(
                      title: "Too hard",
                      onPress: () {
                        setState(() {
                          index = 1;
                        });
                        print(index);
                      },
                      backgroundColor: index == 1
                          ? defaultTextColor
                          : defaultBackgroundColor,
                      textColor: index == 1
                          ?isDark?Colors.white: defaultBackgroundColor
                          : defaultTextColor),
                  getButton(
                      title: "Don't know how to do it",
                      onPress: () {
                        index = 2;
                      },
                      backgroundColor: index == 2
                          ? defaultTextColor
                          : defaultBackgroundColor,
                      textColor: index == 2
                          ?isDark?Colors.white: defaultBackgroundColor
                          : defaultTextColor),
                  getButton(
                      title: "Not enough time",
                      onPress: () {
                        index = 3;
                      },


                      backgroundColor: index == 3
                          ? defaultTextColor
                          : defaultBackgroundColor,
                      textColor: index == 3
                          ?isDark?Colors.white: defaultBackgroundColor
                          : defaultTextColor),
                  getButton(
                      title: "Other reason",
                      onPress: () {
                        index = 4;
                      },

                      backgroundColor: index == 4
                          ? defaultTextColor
                          : defaultBackgroundColor,
                      textColor: index == 4
                          ?isDark?Colors.white: defaultBackgroundColor
                          : defaultTextColor),
                  Spacer(flex: 4,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
