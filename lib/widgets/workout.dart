


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';

class SecondScreen extends StatelessWidget {
  static const String routeName = '/second-screen';
  final String title;
  final List<Workout> beginner;
  final List<Workout> intermediate;
  final List<Workout> advance;

  SecondScreen({
    @required this.title,
    @required this.beginner,
    @required this.intermediate,
    @required this.advance,
  });

  final titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //   Expanded(
          Card(
            color: Colors.purple.withOpacity(.5),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    title + " Beginner",
                    style: titleStyle,
                  ),
                  trailing: Container(
                    height: 30,
                    width: 30,
                    child: Row(
                      children: [Icon(Icons.star_border)],
                    ),
                  ),
                  onTap: () {


                  },
                  subtitle: Container(
                    width: 50,
                    height: 30,
                    child: Row(children: [
                      Text("12 Exercise"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("25 Minute"),
                    ]),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(title + " Intermediate", style: titleStyle),
                  trailing: Container(
                    height: 30,
                    width: 50,
                    child: Row(
                      children: [
                        Icon(Icons.star_border),
                        Icon(Icons.star_border)
                      ],
                    ),
                  ),
                  onTap: () {

                  },
                  subtitle: Container(
                    width: 50,
                    height: 30,
                    child: Row(children: [
                      Text("12 Exercise"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("25 Minute"),
                    ]),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(title + " Advance", style: titleStyle),
                  trailing: Container(
                    height: 30,
                    width: 80,
                    child: Row(
                      children: [
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border)
                      ],
                    ),
                  ),
                  onTap: () {

                  },
                  subtitle: Container(
                    width: 50,
                    height: 30,
                    child: Row(children: [
                      Text("12 Exercise"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("25 Minute"),
                    ]),
                  ),
                ),
                Divider(),
              ],
            ),
          )
          //)
        ],
      ),
    );
  }
}
