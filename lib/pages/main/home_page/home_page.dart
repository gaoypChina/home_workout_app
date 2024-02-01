import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../models/main_page_item.dart';
import '../../../widgets/active_goal.dart';
import '../../../widgets/dialogs/exit_app_dialog.dart';
import '../../../widgets/workout_card.dart';
import 'leading_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    getTitle(String title) {
      return Container(
        padding: EdgeInsets.only(left: 12, top: 22, bottom: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color: Theme.of(context).primaryColor.withOpacity(.8)),
              height: 16,
              width: 5,
            ),
            SizedBox(
              width: 8,
            ),
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.8),
                  letterSpacing: 1.0,
                )),
          ],
        ),
      );
    }

    List<Widget> sections = [
      SizedBox(
        height: 18,
      ),
      ActiveGoal(),
      getTitle(exerciseName[0]),
      for (int i = 0; i < 3; i++)
        WorkoutCard(
          title: chestExercise[i].title,
          workoutList: chestExercise[i].workoutList,
          tagValue: i,
          imaUrl: chestExercise[i].imageUrl,
          tag: chestExercise[i].title,
          index: 1,
        ),
      getTitle(exerciseName[1]),
      for (int i = 0; i < 3; i++)
        WorkoutCard(
          title: shoulderExercise[i].title,
          workoutList: shoulderExercise[i].workoutList,
          tagValue: i,
          imaUrl: shoulderExercise[i].imageUrl,
          tag: shoulderExercise[i].title,
          index: 0,
        ),
      getTitle(exerciseName[2]),
      for (int i = 0; i < 3; i++)
        WorkoutCard(
          title: absExercise[i].title,
          workoutList: absExercise[i].workoutList,
          tagValue: i,
          imaUrl: absExercise[i].imageUrl,
          tag: absExercise[i].title,
          index: 0,
        ),
      getTitle(exerciseName[3]),
      for (int i = 0; i < 3; i++)
        WorkoutCard(
          title: legsExercise[i].title,
          workoutList: legsExercise[i].workoutList,
          tagValue: i,
          imaUrl: legsExercise[i].imageUrl,
          tag: legsExercise[i].title,
          index: 1,
        ),
      getTitle(exerciseName[4]),
      for (int i = 0; i < 3; i++)
        WorkoutCard(
          title: armsExercise[i].title,
          workoutList: armsExercise[i].workoutList,
          tagValue: i,
          imaUrl: armsExercise[i].imageUrl,
          tag: armsExercise[i].title,
          index: 0,
        ),
      SizedBox(height: 20),
    ];

    return WillPopScope(
        onWillPop: () => exitAppDialog(context: context),
        child: Scaffold(
          backgroundColor: isDark
              ? Colors.blueGrey.shade300.withOpacity(.05)
              : Colors.blueGrey.shade300.withOpacity(.1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: getLeading(context),
            elevation: 0.2,
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Home ".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      letterSpacing: 1,
                      //  color: Theme.of(context).primaryColor,
                      fontSize: 18)),
              TextSpan(
                  text: "Workout".toUpperCase(),
                  style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 18))
            ])),
          ),
          body: AnimationLimiter(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: sections.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 605),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: sections[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
