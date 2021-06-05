import 'package:flutter/material.dart';
import 'package:full_workout/database/workoutlist.dart';

class TrainingPage extends StatefulWidget {
  final List<WorkoutList> workOutList;
  const TrainingPage({this.workOutList});

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.workOutList.length,
          itemBuilder: (context,index){
          WorkoutList item =  widget.workOutList[index];
        return Container(
          child: Stack(children: [
   
            Text(item.imageSrc)
          ],),
        );
      }),
    );

  }
}
