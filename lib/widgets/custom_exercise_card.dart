import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_dialog_box.dart';


class CustomExerciseCard extends StatefulWidget {

  final String title;
  final String imgUrl;
  final int time;
  final Function tap;
  final List steps;
  final String link;

  CustomExerciseCard(
      {
      this.title,
      this.imgUrl,
      this.time,
      this.tap,
      this.steps,
      this.link});

  @override
  _CustomExerciseCardState createState() => _CustomExerciseCardState();
}

class _CustomExerciseCardState extends State<CustomExerciseCard> {
  bool isActive = false;
  int boxHeight = 4;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => MyDialog(
                  title: widget.title,
                  imgUrl: widget.imgUrl,
                  link: widget.link,
                  steps: widget.steps,
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
                        widget.imgUrl,
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
                        widget.title,
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
                          Text(widget.time.toString()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.calendar_today,
                    //       color: Colors.red,
                    //     ),
                    //     SizedBox(width: 10),
                    //     //   Text(widget.complete),
                    //   ],
                    // ),
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
