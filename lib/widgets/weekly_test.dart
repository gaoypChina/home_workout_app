import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';

class WeeklyTest extends StatefulWidget {
  @override
  _WeeklyTestState createState() => _WeeklyTestState();
}

class _WeeklyTestState extends State<WeeklyTest> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(children: [
          ...fullBodyChallenge
              .map((challenge) => Column(children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.blue,
                      child: Row(
                        children: [
                          Text("Day ${++i}"),
                          Spacer(),
                          Text(challenge.length.toString())
                        ],
                         ),
                       ),
                       ...challenge.map((curr) {
                         int time = 0;
                      int currDay = 0;

                      if (curr.showTimer == false) {
                          currDay = i;
                          if (currDay <= 10) {
                            time = curr.beginnerRap;

                          } else if (currDay <= 20) {
                            time = curr.intermediateRap;

                          } else{
                            time = curr.advanceRap;

                          }
                        } else if (curr.showTimer == true) {
                           time = curr.duration;
                         }
                      return Column(
                        children: [
                          Row(children: [
                            Image.asset(curr.imageSrc,height: 20,),
                           // Text(curr.title.toString()),
                            Spacer(),
                            time.toString() == "null"
                                ? Container(
                                    child: Text("null"),
                                    width: 100,
                                    color: Colors.red,
                                  )
                                : Text(time.toString())
                          ]),
                          Divider(height: 2,color: Colors.black,thickness: 1,),
                        ],
                      );
                       }).toList()
                     ]))
              .toList()
      ]),
    ),
        ));
  }
}


class DailyTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              ...chestBeginner.map((curr) {
                int time = 0;
                if (curr.showTimer == false) {
                  List<String> splitTitle = curr.title.split(" ");
                  if (splitTitle.length == 5) {
                    int currDay = int.tryParse(splitTitle[4]);
                    if (currDay < 10) {
                      time = curr.beginnerRap;
                    } else if (currDay < 20) {
                      time = curr.intermediateRap;
                    } else
                      time = curr.advanceRap;
                  } else {
                    String tag = "beginner";
                    if (tag == 'beginner') {
                      time = curr.beginnerRap;
                    } else if (tag == "intermediate") {
                      time = curr.intermediateRap;
                    } else
                      time = curr.advanceRap;
                  }
                } else if (curr.showTimer == true) {
                  time = curr.duration;
                }

                return Row(
                    children: [Text(curr.title.toString()),
                      Spacer(),
                      time.toString() == "null"?Container(child: Text("null"),width: 100,color: Colors.red,) :Text(time.toString())
                    ]
                );
              }).toList()
            ],
          ),
        ),
      ),
    );
  }
}
