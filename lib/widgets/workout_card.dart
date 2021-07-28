import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/pages/workout_page/exercise_list_page.dart';

import '../main.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final List<Workout> workoutList;
  final int tagValue;
  final String imaUrl;
  final String tag;

  const WorkoutCard(
      {@required this.title,
      @required this.workoutList,
        @required this.tagValue,

      @required this.imaUrl,
      @required this.tag});

  @override
  Widget build(BuildContext context) {
    int totalExercise = workoutList.length;
    getDuration(int totalExercise) {
      getIValue() {
        if (totalExercise < 15) {
          return 0;
        } else if (totalExercise < 20) {
          return 1;
        }
        return 2;
      }

      return Row(
        children: [
          Text("Duration",
              style: textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            width: 10,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                //      border: Border.all(color: Colors.blue.shade700,width: 2)
              ),
              width: 35,
              height: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 3; i++)
                    Icon(
                      Icons.circle,
                      size: 8,
                      color:
                          getIValue() < i ? Colors.grey : Colors.blue.shade700,
                    ),
                ],
              )),
        ],
      );
    }

    getDifficulty() {
      return Row(
        children: [
          Text("Difficulty",
              style: textTheme.subtitle2.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            width: 10,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                //      border: Border.all(color: Colors.blue.shade700,width: 2)
              ),
              width: 35,
              height: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 3; i++)
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: tagValue < i ? Colors.grey : Colors.blue.shade700,
                    ),
                ],
              )

              // ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   physics: NeverScrollableScrollPhysics(),
              //     itemCount: tagValue+1, itemBuilder: (context, index) {
              //   return Icon(
              //     Icons.circle,
              //     color: Colors.blue,
              //     size: 8,
              //   );
              // }),
              ),
        ],
      );
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExerciseListScreen(
                    workOutList: workoutList,
                    tag: tag,
                    title: title,
                  tagValue: tagValue,)),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          child: Container(
            height: 130,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage(
                      "assets/cover/chest.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.4, 0.5, 0.9],
                      colors: [
                        Colors.black.withOpacity(.8),
                        Colors.black54.withOpacity(.2),
                        Colors.white.withOpacity(.1),
                        Colors.white.withOpacity(.1),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, top: 12, right: 18, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme.bodyText1.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          totalExercise.toString() + " Exercise",
                          style: textTheme.bodyText2.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            getDuration(totalExercise),
                            SizedBox(
                              width: 40,
                            ),
                            getDifficulty(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

