import 'package:flutter/material.dart';

import '../../../../database/explore_page_workout/export_workout.dart';
import '../../../../models/explore_workout_model.dart';
import '../body_focus_workout_page/body_focus_workout_page.dart';

class BodyFocusWorkout extends StatelessWidget {
  const BodyFocusWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BodyFocusWorkoutModel> _challenges = [
      BodyFocusWorkoutModel(
          workoutList: ExportWorkout().chestWorkoutList,
          title: "Chest Workout",
          imgSrc: "assets/icons/push-up.png",
          coverImg: "assets/explore_image/img_8.jpg",
          color: Colors.blueGrey,
         description: [
           "Exercises for chest results in building a bigger and wider chest that tapers into a narrow waist, offering you exactly what you are looking for through your fitness routine.",
           "Exercises for chest, when performed regularly and in the right way, trains the deltoids and introduces a healthy balance of muscles."
         ]),
      BodyFocusWorkoutModel(
          workoutList: ExportWorkout().buttAndLesWorkoutList,
          title: "Butt & Legs",
          coverImg: "assets/explore_image/img_8.jpg",
          imgSrc: "assets/icons/exercises.png",
          color: Colors.redAccent,
          description: [
            "Legs are the pillars for a healthy body and training them should be a top priority for overall physique and health.",
            "The power generated from your lower half is essential for nearly every sport. A well-developed lower body will allow you to exert a maximal amount of force in a minimal amount of time, which in turn makes you faster and stronger.",
          ]),
      BodyFocusWorkoutModel(
          workoutList: ExportWorkout().armsAndShoulderWorkoutList,
          title: "Arms & Shoulder",
          coverImg: "assets/explore_image/img_8.jpg",
          imgSrc: "assets/icons/lunges.png",
          color: Colors.teal,
          description: ["The shoulder muscles are responsible for maintaining the widest range of motion of any joint in your body.",
            "Strong arms and shoulder can help you with everyday tasks such as lifting heavy objects or playing sports"]),
      BodyFocusWorkoutModel(
          workoutList: ExportWorkout().sixPackAbsWorkoutList,
          title: "Six Pack Abs",
          coverImg: "assets/explore_image/img_8.jpg",
          imgSrc: "assets/icons/fitness.png",
          color: Colors.brown,
          description: [
            "The abdominal muscles contract and force the diaphragm upwards therefore providing further power to empty your lungs. Stronger abdominals will give you the ability to run faster and for longer periods of time.",
            "Strong core muscles are also important for athletes, such as runners, as weak core muscles can lead to more fatigue, less endurance and injuries."
          ]

         ),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          "Body Focus Workout",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.2),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 9 / 8,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: [
          ..._challenges.map((workout) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return BodyFocusWorkoutPage(
                          workoutModel: workout,
                        );
                      }));
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              gradient: LinearGradient(
                                  colors: [
                                    workout.color.withOpacity(.6),
                                    workout.color.withOpacity(.8),
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  tileMode: TileMode.mirror)),
                          padding:
                              EdgeInsets.only(bottom: 12, left: 8, right: 8),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              workout.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 18, bottom: 8, top: 8, right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(0)),
                                    color: workout.color.withOpacity(.8)),
                                height: 70,
                                child: Image.asset(
                                  workout.imgSrc,
                                )))
                      ],
                    ),
                  ),
                ),
              ))
        ],
      )
    ]);
  }
}

class BodyFocusWorkoutModel {
  final List<ExploreWorkout> workoutList;
  final Color color;
  final String imgSrc;
  final String title;
  final String coverImg;
  final List<String> description;

  BodyFocusWorkoutModel(
      {required this.workoutList,
      required this.color,
      required this.imgSrc,
      required this.title,
      required this.coverImg,
      required this.description});
}
