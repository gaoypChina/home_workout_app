import 'package:flutter/material.dart';

import '../main_page.dart';

class StopPage extends StatelessWidget {
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
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: backgroundColor,
              side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  style: BorderStyle.solid,
                  width: 2),
            ),
            onPressed: () => onPress(),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .merge(TextStyle(color: textColor)),
            )),
      );
    }

    Color defaultTextColor = Colors.white;
    Color defaultBackgroundColor = Colors.transparent;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/other/backgroudnd_2.jpg",
            height: double.infinity,

            // width: width,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.7),
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 18),
                height: MediaQuery.of(context).size.height * .4,
              ),
              Spacer(),
              Text(
                "Workout Paused",
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700),
              ),
              Spacer(),
              getButton(
                  title: "Restart Program",
                  onPress: () async {
                    String res = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Restart Session form Beginning?",
                              style:
                                  TextStyle(fontSize: 14, letterSpacing: 1.2),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "resume"),
                                  child: Text("Cancel")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "restart"),
                                  child: Text("Restart"))
                            ],
                          );
                        });
                    if (res == "restart") {
                      Navigator.pop(context, res);
                    }
                  },
                  backgroundColor: defaultBackgroundColor,
                  textColor: defaultTextColor),
              getButton(
                  title: "Quit",
                  onPress: () async {
                    String res = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // backgroundColor: Theme.of(context).cardColor,
                            content: Text(
                              "Do you want to quit the exercise session?",
                              style:
                                  TextStyle(fontSize: 14, letterSpacing: 1.2),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "quit"),
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "restart"),
                                  child: Text("No"))
                            ],
                          );
                        });

                    if (res == "quit") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                    index: 0,
                                  )));
                    }
                  },
                  backgroundColor: defaultBackgroundColor,
                  textColor: defaultTextColor),
              Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: ElevatedButton(
                  child: Text(
                    "Resume",
                  ),
                  onPressed: () => Navigator.pop(context, "resume"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              Spacer(),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
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
    );
  }
}
