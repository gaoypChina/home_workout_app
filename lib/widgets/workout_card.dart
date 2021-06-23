import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/pages/workout_page/exercise_list_page.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final List<Workout> workoutList;
  final int star;
  final String imaUrl;
  final String tag;

  const WorkoutCard(
      {@required this.title,
      @required this.workoutList,
      @required this.star,
      @required this.imaUrl,
      @required this.tag});

  @override
  Widget build(BuildContext context) {
    int totalExercise = workoutList.length;
    int time = totalExercise * 2 - 2;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Card(
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
                      tag: "B",
                      title: title,
                      stars: star)),
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
                      padding: const EdgeInsets.only(left: 18.0,top: 12),
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
                          Row(
                            children: [
                              Text(
                                totalExercise.toString() + " Exercise",
                                style: textTheme.bodyText2
                                    .copyWith(color: Colors.amber),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "25 Minute",
                                style: textTheme.bodyText2
                                    .copyWith(color: Colors.amber),
                              )
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                                itemCount: star+1, itemBuilder: (context, index) {
                              return Icon(
                                Icons.flash_on,
                                color: Colors.amber,
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

