import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/explore_page_workout/export_workout.dart';

import '../../../../database/workout_list.dart';
import '../all_ercise_page/all_exercise_page.dart';
import '../all_workout_page/all_workout_page.dart';

class TopPicksSection extends StatelessWidget {
  const TopPicksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Discover All Workouts",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.0),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Column(
          children: [
            ListTile(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllWorkoutPage())),
              leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.border_all,
                    color: Colors.white,
                  )),
              title: Text("All Workouts"),
              subtitle: Text("${allExploreWorkout.length} Workouts"),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return AllExercisePage();
                }));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.apps_outlined,
                    color: Colors.white,
                  )),
              title: Text("All Exercise"),
              subtitle: Text("Total ${allWorkOut.length} Workouts"),
            )
          ],
        )
      ],
    );
  }
}
