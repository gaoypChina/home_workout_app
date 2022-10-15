import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/explore_page/widget/workout_header.dart';
import '../../../../database/explore_page_workout/picked_workout_database.dart';
import '../../../../database/explore_page_workout/stretch_workout.dart';
import '../workout_setup_page/workout_setup_page.dart';

class OtherWorkoutCard extends StatelessWidget {

  const OtherWorkoutCard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text("Featured Workout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
            height: 300,
            child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 15 / 16,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                children: [
                  ...stretchWorkoutList.map((workout) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => WorkoutSetupPage(
                                workout: workout,
                                header: ExploreWorkoutHeader(imgSrc: workout.imgSrc,title: workout.title,workoutType: workout.workoutType),
                              ))),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        child: Image.asset(
                                          workout.imgSrc,
                                          fit: BoxFit.fill,
                                        )))),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                workout.title,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.4,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(.7)),
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ]))
      ],
    );
  }
}
