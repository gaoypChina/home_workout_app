

import 'package:flutter/material.dart';

import '../../../../database/workout_list.dart';

class AllExercisePage extends StatelessWidget {
  const AllExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Exercise"),),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        physics: BouncingScrollPhysics(),
        itemCount: allWorkOut.length,
          separatorBuilder: (context,index){
        return  Divider(
          color: Colors.blue.withOpacity(.5),
        );
          },
          itemBuilder: (context, index) {

        return GestureDetector(
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExerciseInstCard(workout: allWorkOut.elementAt(index),))),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [

                Expanded(child: Image.asset(allWorkOut.elementAt(index).imageSrc)),
                SizedBox(width: 18,),
                Expanded(
                  flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(allWorkOut.elementAt(index).title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                        Card(child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Beginner"),
                        ),color: Colors.green.withOpacity(.2),)
                      ],
                    ))
              ],
            ),
          ),
        );
      }));


}}



class ExerciseInstCard extends StatelessWidget {
  final Workout workout;

  const ExerciseInstCard({Key? key,required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(workout.title),),
      body: Stack(
        children: [

          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0,top: 18,bottom: 12),
                child: Text(workout.title,style: TextStyle(color: Colors.green.shade500,fontSize: 38,fontWeight: FontWeight.w600),),
              ),
             ListView.builder(
              shrinkWrap: true,
              itemCount: workout.steps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ListTile(

                    leading: Container(
                      child: Text("${index + 1}",style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.bold),),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2,color: Colors.green),

                      ),
                    ),
                    title: Text(workout.steps[index],style: TextStyle(color: Colors.green,fontSize: 16,letterSpacing: 1.2),),
                  ),
                );

    })
            ],
          ),
        ],
      ),
    );
  }
}
