import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: workoutList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * .4,
            child: Image.asset(allWorkOut[index].imageSrc),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 100,
            child: Column(
              children: [
                Text("index : ${index+1}"),
                Text(allWorkOut[index].imageSrc),
                Text(allWorkOut[index].title),
                Spacer(),
                Container(height: 5,color: Colors.black,),
              ],
            ),
          );
        },
      ),
    );
  }
}
