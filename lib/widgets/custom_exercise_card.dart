import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/main.dart';
import 'package:full_workout/pages/workout_page/detail_dialog_page.dart';



class CustomExerciseCard extends StatefulWidget {
  final List<Workout> workOutList;
  final int index;
  final int time;
  CustomExerciseCard({this.workOutList, this.index, this.time});

  @override
  _CustomExerciseCardState createState() => _CustomExerciseCardState();
}

class _CustomExerciseCardState extends State<CustomExerciseCard> {
  bool isActive = false;
  int boxHeight = 4;

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    var item = widget.workOutList[widget.index];
    return  Card(
        elevation: 0,
        margin: EdgeInsets.only(bottom: 0),
        shape: RoundedRectangleBorder(side: BorderSide(color:isDark?Colors.blue.shade100: Colors.blue.shade700,width: 1.5),
          borderRadius: BorderRadius.circular(16),
        ),
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
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20,),

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16) ),
                  child: Container(
                    color: Colors.white,
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
            ),
            Container(width: 1.5,height: 100,color:isDark?Colors.blue.shade100: Colors.blue.shade700,),
            Expanded(
              flex: 3,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
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
