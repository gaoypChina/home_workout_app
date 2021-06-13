import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/widgets/info_button.dart';

class QuitPage extends StatefulWidget {

  @override
  _QuitPageState createState() => _QuitPageState();
}

class _QuitPageState extends State<QuitPage> {
  int index =0;
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
        margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backgroundColor,
              side: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 0),
            ),
            onPressed: () {

              onPress();
              setState(() {
                
              });
            },
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .merge(TextStyle(color: textColor)),
            )),
      );
    }

    Color defaultTextColor = Colors.blue;
    Color defaultBackgroundColor = Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InfoButton(
                        icon: Icons.arrow_back,
                        onPress: () {print(index);
                          //    Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    "Pause",
                    style: textTheme.headline1.copyWith(
                        color: Colors.white,
                        fontSize: 40,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
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
index =4;
                      },
                      backgroundColor: index == 4
                          ? defaultTextColor
                          : defaultBackgroundColor,
                      textColor: index == 4
                          ? defaultBackgroundColor
                          : defaultTextColor),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            color: Colors.white,
            child: getButton(
                title: "Quite",
                onPress: () {},
                backgroundColor: Colors.blue,
                textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
