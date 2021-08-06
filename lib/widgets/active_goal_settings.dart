import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

import '../main.dart';

class WeekGoalSettings extends StatefulWidget {
  @override
  _WeekGoalSettingsState createState() => _WeekGoalSettingsState();
}

class _WeekGoalSettingsState extends State<WeekGoalSettings> {
  SpKey spKey = SpKey();
  SpHelper spHelper = SpHelper();

  List<DayIndex> trainingDay = [
    DayIndex(index: 1, value: "1 Day"),
    DayIndex(index: 2, value: "2 Days"),
    DayIndex(index: 3, value: "3 Days"),
    DayIndex(index: 4, value: "4 Days"),
    DayIndex(index: 5, value: "5 Days"),
    DayIndex(index: 6, value: "6 Days"),
    DayIndex(index: 7, value: "7 Days"),
  ];

  List<DayIndex> firstDay = [
    DayIndex(index: 1, value: "Saturday"),
    DayIndex(index: 2, value: "Sunday"),
    DayIndex(index: 3, value: "Monday")
  ];

  String totalActiveDay = "";
  String startDay = "Sunday";

  int firstDayVal;
  int activeDayVal;

  loadData() async{
    loadDay(int val){
      if(val == 7) return "Sunday";
      if(val == 6) return "Saturday";
      if(val == 1) return "Monday";
    }
   int firstDayRes =await spHelper.loadInt(spKey.firstDay) ?? 7;
   int trainingDayRes = await spHelper.loadInt(spKey.trainingDay)?? 7;
   setState(() {
     totalActiveDay = trainingDayRes.toString() + " Days";
     startDay = loadDay(firstDayRes);
     firstDayVal = firstDayRes;
     activeDayVal = trainingDayRes;
   });
  }

  @override
  void initState() {
loadData();
super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "assets/other/backgroudnd_2.jpg",
        ),
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.grey.withOpacity(.3), BlendMode.difference),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6, top: 22),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade700,
                shape: CircleBorder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Set you weekly goal",
                      style: textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "We recommend training at least 3 days weekly for a better result",
                      style: textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text("Weekly training days",
                        style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white)),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        int res = await showDialog(
                            context: context,
                            builder: (context) {
                              return DaySelector(
                                title: "Weekly Training day",
                                dayList: trainingDay,
                              );
                            });
                        if (res != null) {
                          setState(() {
                            totalActiveDay = res.toString() + " Days";
                            activeDayVal = res;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        height: 40,
                        width: 200,
                        child: Row(
                          children: [
                            Text(totalActiveDay),
                            Spacer(),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("First day of week",
                        style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        int res = await showDialog(
                            context: context,
                            builder: (context) {
                              return DaySelector(
                                title: "First Day of week",
                                dayList: firstDay,
                              );
                            });

                        if (res != null) {
                          String resString = "";
                          if (res == 1) {
                            resString = "Saturday";
                            firstDayVal = 6;
                          } else if (res == 2) {
                            resString = "Sunday";
                            firstDayVal = 7;
                          } else {
                            resString = "Monday";
                            firstDayVal = 1;
                          }
                          setState(() {
                            startDay = resString;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white,
                        ),
                        height: 40,
                        width: 200,
                        child: Row(
                          children: [
                            Text(startDay),
                            Spacer(),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.blue.shade700,
                          onPressed: () {
                            spHelper.saveInt(spKey.firstDay, firstDayVal);
                            spHelper.saveInt(spKey.trainingDay, activeDayVal);
                            Navigator.pop(context, [firstDayVal, activeDayVal]);
                          },
                          label: Text(
                            "SAVE",
                            style: textTheme.button
                                .copyWith(fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class DaySelector extends StatefulWidget {
  final List<DayIndex> dayList;
  final String title;

  DaySelector({this.dayList, this.title});

  @override
  _QuitPageState createState() => _QuitPageState();
}

class _QuitPageState extends State<DaySelector> {
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
              style: Theme.of(context).textTheme.button.merge(TextStyle(
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
            onPressed: () {
              Navigator.pop(context, index);
            },
            label: Text(
              "Submit",
              style:
                  textTheme.button.copyWith(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 8),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
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
                Text(
                  widget.title,
                  style: textTheme.headline1.copyWith(
                      color: Colors.black,
                      fontSize: 30,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                ...widget.dayList
                    .map((item) => getButton(
                        title: item.value,
                        backgroundColor: index == item.index
                            ? defaultTextColor
                            : defaultBackgroundColor,
                        textColor: index == item.index
                            ? defaultBackgroundColor
                            : defaultTextColor,
                        onPress: () {
                          setState(() {
                            index = item.index;
                          });
                          print(index);
                        }))
                    .toList(),
                Spacer(

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DayIndex {
  int index;
  String value;

  DayIndex({this.index, this.value});
}
