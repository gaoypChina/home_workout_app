import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:intl/intl.dart';
import 'package:full_workout/pages/workout_page/exercise_list_page.dart';

import '../main.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final List<Workout> workoutList;
  final int tagValue;
  final String imaUrl;
  final String tag;
  final int index;
  final List<Color> color;

  WorkoutCard({
    @required this.title,
    @required this.workoutList,
    @required this.tagValue,
    @required this.imaUrl,
    @required this.tag,
    @required this.index,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    getLastDate() {
      return FutureBuilder(
        future: SpHelper().loadString(title),
        builder: (context, snapShot) {
          print("Last Date : ${snapShot.data}");
          if (snapShot.hasData) {
            String date =
                DateFormat.MMMd().format(DateTime.parse(snapShot.data));
            return Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 8),
              child: Text("Last Time : $date",
                  style: textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
            );
          } else
            return Container();
        },
      );
    }

    getDuration(int totalExercise) {
      getIValue() {
        if (totalExercise < 15) {
          return 0;
        } else if (totalExercise < 20) {
          return 1;
        }
        return 2;
      }

      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  color: getIValue() < i ? Colors.grey : Colors.blue.shade700,
                ),
            ],
          ));
    }

    getDifficulty() {
      return Container(
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
          ));
    }

    getImage() {
      return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
        child: Container(
          width: width * .45,
          child: Image.asset(
            "assets/all-workouts/cobraStratch.png",
            fit: BoxFit.fill,
          ),
        ),
      );
    }

    getTitle() {
      return Expanded(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                getLastDate(),
                SizedBox(height: 12,),

                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Difficulty",
                          style: textTheme.headline3
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        getDifficulty()
                      ],
                    ),
                    Spacer(flex: 2,),
                    Column(
                      children: [
                        Text(
                          "Duration",
                          style: textTheme.headline3
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        getDuration(workoutList.length)
                      ],
                    ),
                    Spacer(flex: 1,),
                  ],
                ),

              ],
            ),
          ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Ink(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExerciseListScreen(
                        workOutList: workoutList,
                        tag: tag,
                        title: title,
                        tagValue: tagValue,
                      )),
            );
          },
          child: Container(
            height: height * .18,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color[0], color[1]],
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  getImage(),
                  getTitle(),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    //   Card(
    //   elevation: 5,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(12.0),
    //     ),
    //   ),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ExerciseListScreen(
    //                 workOutList: workoutList,
    //                 tag: tag,
    //                 title: title,
    //               tagValue: tagValue,)),
    //       );
    //     },
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(12.0),
    //       ),
    //       child: Container(
    //         height: 130,
    //         child: Stack(
    //           children: [
    //             Container(
    //               width: double.infinity,
    //               child: Image(
    //                 image: AssetImage(
    //                   "assets/cover/chest.jpg",
    //                 ),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             Container(
    //               decoration: BoxDecoration(
    //                 gradient: LinearGradient(
    //                   begin: Alignment.bottomCenter,
    //                   end: Alignment.topCenter,
    //                   stops: [0.1, 0.4, 0.5, 0.9],
    //                   colors: [
    //                     Colors.black.withOpacity(.8),
    //                     Colors.black54.withOpacity(.2),
    //                     Colors.white.withOpacity(.1),
    //                     Colors.white.withOpacity(.1),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(
    //                     left: 18.0, top: 12, right: 18, bottom: 10),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       title,
    //                       style: textTheme.bodyText1.copyWith(
    //                           color: Colors.white,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.w700),
    //                     ),
    //                     SizedBox(
    //                       height: 8,
    //                     ),
    //                     Row(
    //                       children: [
    //                         Text(
    //                           totalExercise.toString() + " Exercise",
    //                           style: textTheme.bodyText2.copyWith(
    //                               color: Colors.white,
    //                               fontSize: 14,
    //                               fontWeight: FontWeight.w600),
    //                         ),
    //                         SizedBox(width: 20,),
    //                         getLastDate()
    //                       ],
    //                     ),
    //                     Spacer(),
    //                     Row(
    //                       children: [
    //                         getDuration(totalExercise),
    //                         SizedBox(
    //                           width: 40,
    //                         ),
    //                         getDifficulty(),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

