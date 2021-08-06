import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class ReportShare extends StatelessWidget {
  final String date;
  final int calories;
  final int time;
  final int exercise;
  final String title;

  ReportShare(
      {@required this.date,
      @required this.title,
      @required this.time,
      @required this.calories,
      @required this.exercise});

  @override
  Widget build(BuildContext context) {
    getCard(int value, String title,Color color) {
      return Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
        //  margin: EdgeInsets.symmetric(vertical: 18),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.blue.shade700),
          child: Column(
            children: [
              Text(
                value.toString(),
                style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4,),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Colors.white),
              )
            ],
          ),
        ),
      );
    }

    String parsedDate = DateFormat.MMMd().format(DateTime.parse(date));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.blue.shade700,
          gradient: LinearGradient(
              colors: [ Colors.red, Colors.blue.shade900,])
    ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parsedDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 38,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCard(time, "Minute",Colors.green),
                getCard(exercise, "Exercise",Colors.red),
                getCard(calories, "Calories",Colors.orange)
              ],
            ),
          ),
          SizedBox(height: 34,),
          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),

                  ),
                  height: 60,
                  width: 160,
                  padding: EdgeInsets.only(left: 6, right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Icon(
                        Entypo.google_play,
                        color: Colors.white,
                        size: 35,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "GET IT ON",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Google play",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Spacer(),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    height: 60,
                    width: 160,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)),color: Colors.black12,),

                              child: Image.asset(
                          "assets/app_icon.png",
                        ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Workout",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          ),
SizedBox(height: 10,)
        ],
      ),
    );
  }
}
