import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workoutlist.dart';

import 'my_dialog_box.dart';


class CustomExerciseCard extends StatefulWidget {
  final List<WorkoutList> workOutList;
  final int index;
  CustomExerciseCard({this.workOutList, this.index});

  @override
  _CustomExerciseCardState createState() => _CustomExerciseCardState();
}

class _CustomExerciseCardState extends State<CustomExerciseCard> {
  bool isActive = false;
  int boxHeight = 4;

  @override
  Widget build(BuildContext context) {
    var item = widget.workOutList[widget.index];
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => MyDialog(
                 workoutList: widget.workOutList,
              index: widget.index,
                ));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 0),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            Container(width: 1,height: 100, color: Colors.blue,),
            Expanded(
              flex: 3,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
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
                          Icon(
                            Icons.access_time,
                          ),
                          SizedBox(width: 10),
                          Text(item.duration.toString()),
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
