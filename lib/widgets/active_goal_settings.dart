import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:numberpicker/numberpicker.dart';

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
   int trainingDayRes = await spHelper.loadInt(spKey.trainingDay)?? 2;
   setState(() {
     totalActiveDay =trainingDayRes==1?trainingDayRes.toString() + " Day": trainingDayRes.toString() + " Days";
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


    return Scaffold(
      backgroundColor:Colors.black,

      body: Container(

        decoration: BoxDecoration(

            image: DecorationImage(
              image: AssetImage("assets/other/backgroudnd_2.jpg",),fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode( Colors.black.withOpacity(0.4) , BlendMode.dstATop),
            )),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 22),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.arrow_back,color: Colors.white,),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
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
                        "Set your weekly goal",
                        style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "We recommend training at least 3 days weekly for a better result",
                        style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 30),
                      Text("Weekly training days",
                          style: textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white)),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () async {

                          int res =await showDialog(context: context, builder: (context){
                            return DaySelector(
                              title: "Weekly training days",
                              initialValue: activeDayVal,
                              dayList: trainingDay,
                            );
                          });

                          if (res != null) {
                            setState(() {
                              totalActiveDay =res==1?res.toString() + " Day": res.toString() + " Days";
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
                              Text(totalActiveDay,style: TextStyle(color: Colors.black),),
                              Spacer(),
                              Icon(Icons.arrow_drop_down_rounded,color: Colors.black,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("First day of week",
                          style: textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.w500,
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
                                  initialValue:firstDayVal==6? 1:firstDayVal==7?2:3,
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
                              Text(startDay,style: TextStyle(color: Colors.black),),
                              Spacer(),
                              Icon(Icons.arrow_drop_down_rounded,color: Colors.black,)
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
      ),
    );
  }
}

class DaySelector extends StatefulWidget {
  final List<DayIndex> dayList;
  final String title;
  final int initialValue;

  DaySelector({this.dayList, this.title, this.initialValue});

  @override
  _QuitPageState createState() => _QuitPageState();
}

class _QuitPageState extends State<DaySelector> {
  Constants constants = Constants();
  int selectedValue = 2;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }



@override
   Widget build(BuildContext context){
  return AlertDialog(
    title: Text(widget.title),
    content: NumberPicker(
      haptics: true,

      value: selectedValue,
      step:1,
      minValue: 1,
      maxValue: widget.dayList.length,
      selectedTextStyle: TextStyle(color: Colors.blue.shade700,fontSize: 22,fontWeight: FontWeight.w500),
      textMapper: (title) {
        return widget.dayList[int.parse(title)-1].value;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
      ),
      TextButton(
          onPressed: () => Navigator.pop(context, selectedValue),
          child: Text("Save")),
    ],
  );
}
}

class DayIndex {
  int index;
  String value;

  DayIndex({this.index, this.value});
}

