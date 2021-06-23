import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/workout_page/quit_page.dart';

class StopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getButton(
        {Function onPress,
        String title,
        Color textColor,
        Color backgroundColor}) {
      return
        Container(
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
            onPressed: onPress,
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context,"resume"),
                  child: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: CircleBorder(),
                  ),
                )
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
                title: "Start from beginning",
                onPress: () {},
                backgroundColor: defaultBackgroundColor,
                textColor: defaultTextColor),
            getButton(
                title: "Restart this exercise",
                onPress: () =>Navigator.pop(context,"restart"),
                backgroundColor: defaultBackgroundColor,
                textColor: defaultTextColor),
            getButton(
                title: "Quit",
             onPress: () async {
               bool value = await    showDialog(
                    context: context, builder: (builder) => QuitPage());
               value == true ?? Navigator.of(context).pop();
                },
                backgroundColor: defaultBackgroundColor,
                textColor: defaultTextColor),
            getButton(
                title: "Resume",
                onPress: () =>Navigator.pop(context,"resume"),
                backgroundColor: Colors.blue,
                textColor: Colors.white),
            SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
