import 'package:flutter/material.dart';

import '../../../../widgets/prime_icon.dart';

class WorkoutHeader extends StatelessWidget {
  final String imgSrc;

  const WorkoutHeader({Key? key, required this.imgSrc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(imgSrc),
        Positioned(right: 8, top: 4, child: PrimeIcon())
      ],
    );
  }
}

class AnimatedWorkoutHeader extends StatelessWidget {
  final Color color;
  final String title;
  final String imgSrc;

  const AnimatedWorkoutHeader(
      {Key? key,
      required this.imgSrc,
      required this.color,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.blue,
              gradient: LinearGradient(colors: [
                color.withOpacity(isDark? .2:.6),
                color.withOpacity(isDark? .3:.8),
              ])),
          padding: EdgeInsets.only(bottom: 18, left: 18, right: 18),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: 24, letterSpacing: 1.2),
            ),
          ),
        ),
        Positioned(
            left: 0,
            top: 0,
            child: Container(
                padding: EdgeInsets.only(left: 18, bottom: 8, top: 8, right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(18)),
                    color: color.withOpacity(isDark ? .1: .5)),
                height: 150,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    imgSrc,
                  ),
                ))),
        Positioned(right: 8, top: 8, child: PrimeIcon())
      ],
    );
  }
}
