import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/main.dart';
import 'package:full_workout/pages/workout_page/detail_dialog_page.dart';



class CustomExerciseCard extends StatefulWidget {
  final List<Workout> workOutList;
  final int index;
  final int time;
  CustomExerciseCard({required this.workOutList, required this.index, required this.time});

  @override
  _CustomExerciseCardState createState() => _CustomExerciseCardState();
}

class _CustomExerciseCardState extends State<CustomExerciseCard> {
  bool isActive = false;
  int boxHeight = 4;

  @override
  Widget build(BuildContext context) {

    var item = widget.workOutList[widget.index];
    return  Container(
        child:InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => WorkoutDetailDialog(
                  rapCount: widget.time,
                  workoutList: widget.workOutList,
                  index: widget.index,
                ));
          },
          child: Row(
          children: <Widget>[
            SizedBox(width: 10,),
            Expanded(
              flex: 2,
              child: Container(
                child: Container(
                  height: 100,
                  child: Center(
                      child: Image.asset(
                        item.imageSrc,
                        fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 8),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: <Widget>[
                          if(!item.showTimer)   Text("X ", style: textTheme.subtitle1,),
                            Text(widget.time.toString(),style: textTheme.subtitle1,),

                     if(item.showTimer)     Text(" Sec", style: textTheme.subtitle1,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
