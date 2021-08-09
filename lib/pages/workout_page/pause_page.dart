import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_workout/pages/workout_page/quit_page.dart';
import '../../main.dart';

class StopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    getButton(
        {Function onPress,
        String title,
        Color textColor,
        Color backgroundColor}) {
      return Container(
          height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
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
            onPressed: onPress,
            child: Text(
                title,
                style: Theme
                    .of(context)
                    .textTheme
                    .button
                    .merge(TextStyle(color: textColor)),
              )),
        );
    }

    Color defaultTextColor = Colors.blue.shade700;
    Color defaultBackgroundColor =isDark?Colors.black: Colors.white;

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .4,
                  width: double.infinity,
                  child: SvgPicture.asset(
                    "assets/other/bee.svg",
                  ),
                ),
                Spacer(),
                Text(
                  "Pause",
                  style: textTheme.headline1.copyWith(
                      color: isDark?Colors.white:Colors.black,
                      fontSize: 40,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),

                getButton(
                    title: "Restart Program",
                    onPress: () async {
                      String res = await showDialog(
                          context: context, builder: (context) {
                        return AlertDialog(
                          content: Text("Restart Program form Beginning"),
                          actions: [
                            TextButton(onPressed: () =>
                                Navigator.pop(context, "resume"),
                                child: Text("Cancel")),
                            TextButton(onPressed: () =>
                                Navigator.pop(context, "restart"),
                                child: Text("Restart"))
                          ],
                        );
                      });
                      Navigator.pop(context, res);
                    },
                    backgroundColor: defaultBackgroundColor,
                    textColor: defaultTextColor),
                getButton(
                    title: "Quit",
                    onPress: () async {
                      bool value = await showDialog(
                          context: context, builder: (builder) => QuitPage());
                      value == true ?? Navigator.of(context).pop();
                    },
                    backgroundColor: defaultBackgroundColor,
                    textColor: defaultTextColor),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),

                  child: ElevatedButton(
                    child: Text("Resume",),
                    onPressed: () => Navigator.pop(context, "resume"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade700,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),)
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, "resume"),
                    child: Icon(Icons.arrow_back),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade700,
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
