import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';
import '../main_page.dart';


class StopPage extends StatelessWidget {
  const StopPage({super.key});

  @override
  Widget build(BuildContext context) {
    getDisabledButton({required Function onPress, required String title}) {
      return InkWell(
        onTap: () => onPress(),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.3),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    getButton({required Function onPress, required String title}) {
      return InkWell(
          onTap: () => onPress(),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ));
    }

    return Scaffold(
      backgroundColor: darkAppBarColor,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context, "resume"),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context, "resume"),
                  child: Container(
                    padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Pause",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 24,
                ),
                getButton(
                    onPress: () => Navigator.pop(context, "resume"),
                    title: "Resume"),
                SizedBox(
                  height: 16,
                ),
                getDisabledButton(
                  title: "Restart Program",
                  onPress: () async {
                    String? res = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Restart Session form Beginning?",

                              style:
                              TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "restart"),
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "resume"),
                                  child: Text("No")),

                              SizedBox(width: 4,)
                            ],
                          );
                        });
                    if (res == "restart") {
                      Navigator.pop(context, res);
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                getDisabledButton(
                  title: "Quit",
                  onPress: () async {
                    String? res = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // backgroundColor: Theme.of(context).cardColor,
                            content: Text(
                              "Do you want to quit the exercise session?",
                              style:
                              TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "quit"),
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, "restart"),
                                  child: Text("No")),
                              SizedBox(width: 4,)
                            ],
                          );
                        });

                    if (res == "quit") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPage(index: 0,)));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
