import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/constants/constants.dart';

import '../../main.dart';
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
        {Function onPress,
          String title,
          Color textColor,
          Color backgroundColor}) {
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
              style: Theme
                  .of(context)
                  .textTheme
                  .button
                  .merge(TextStyle(
                  color: textColor, fontSize: title == "Quit" ? 18 : 14)),
            )),
      );
    }

    Color defaultTextColor = Colors.blue.shade700;
    Color defaultBackgroundColor = Colors.white;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(


        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: () async {
              // ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
              // if (connectivityResult == ConnectivityResult.mobile ||
              //     connectivityResult == ConnectivityResult.wifi) {
              //   constants.getToast("We hope that you will complete your workout next time!");
              // } else {
              // constants.getToast("Network Error!");
              // }
              // print(connectivityResult.toString() + "coonnectivity resutl");
              return Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage()));
            },
            icon: Icon(
              Icons.sentiment_dissatisfied_sharp,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              "Quit Workout",
              style: textTheme.button.copyWith(
                  fontSize: 16, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
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
                    "assets/other/bee.svg",
                  ),
                ),
                Spacer(),


                Text(
                  "Quit",
                  style: textTheme.headline1.copyWith(
                      color: Colors.black,
                      fontSize: 40,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
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
                        ? defaultBackgroundColor
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
                        ? defaultBackgroundColor
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
                        ? defaultBackgroundColor
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
                        ? defaultBackgroundColor
                        : defaultTextColor),
                Spacer(flex: 4,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
