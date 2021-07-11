import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/widgets/workout_card.dart';

import '../main.dart';
import 'achivement.dart';

class MyCustomUI extends StatefulWidget {
  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI>
    with SingleTickerProviderStateMixin {
  Constants constants = Constants();
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getTitle(String title){
      return Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 4),
        child: Text(title.toUpperCase(),
            style: textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            )),
      );
    }
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        brightness: Brightness.dark,
        elevation: 0,
        title: Text('Your App\'s name'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Settings',
            enableFeedback: true,
            icon: Icon(
              CupertinoIcons.gear_alt_fill,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteWhereYouGo(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children:
              [

                Container(margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Achievement(
                    timeTitle: "Time",
                    timeValue: 12,
                    caloriesTitle: "Calories",
                    caloriesValue: 14,
                    exerciseTitle: "Exercise",
                    exerciseValue: 16,
                  ),
                  decoration: BoxDecoration(
                      color: constants.widgetColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: new LinearGradient(
                          colors: [
                            constants.widgetColor,
                            constants.widgetColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  //   height: MediaQuery.of(context).size.height / 5,
                ),
                SizedBox(
                  height: 0,
                ),
                getTitle(exerciseName[0]),
                for (int i = 0; i < 3; i++)
                  WorkoutCard(
                    title: absExercise[i].title,
                    workoutList: absExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: absExercise[i].imageUrl,
                    tag: absExercise[i].tag,
                  ),
                getTitle(exerciseName[1]),
                for (int i = 0; i < 3; i++)
                  WorkoutCard(
                    title: chestExercise[i].title,
                    workoutList: chestExercise[i].workoutList,
                    tagValue: i,
                    imaUrl: chestExercise[i].imageUrl,
                    tag: chestExercise[i].tag,
                  ),
                getTitle(exerciseName[2]),
                for(int i=0; i<3; i++)
                  WorkoutCard(title: shoulderExercise[i].title, workoutList: shoulderExercise[i].workoutList,    tagValue: 1, imaUrl: shoulderExercise[i].imageUrl,tag: shoulderExercise[i].tag,),

                getTitle(exerciseName[3]),
                for(int i=0; i<3; i++)
                  WorkoutCard(title: legsExercise[i].title, workoutList: legsExercise[i].workoutList, tagValue: i, imaUrl: legsExercise[i].imageUrl,tag:legsExercise[i].tag ,),

                getTitle(exerciseName[4]),
                for(int i=0; i<3; i++)
                  WorkoutCard(title: armsExercise[i].title, workoutList: armsExercise[i].workoutList, tagValue: i, imaUrl: armsExercise[i].imageUrl,tag: armsExercise[i].tag,),
                SizedBox(height: 20,)

            ],
          ),
          // top me rahna
          CustomPaint(
            painter: MyPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
    );
  }

  Widget cards() {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteWhereYouGo(),
                ));
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffEDECEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.1),
                  radius: _w / 15,
                  child: FlutterLogo(size: 30),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Example',
                        textScaleFactor: 1.6,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                      Text(
                        'Example',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(.8),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.fill;

    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .1, 0)
      ..cubicTo(size.width * .05, 0, 0, 20, 0, size.width * .08);

    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .9, 0)
      ..cubicTo(
          size.width * .95, 0, size.width, 20, size.width, size.width * .08);

    Paint paint_2 = Paint()
      ..color = Color(0xffF57752)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RouteWhereYouGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text('EXAMPLE PAGE',
            style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w600,
                letterSpacing: 1)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black.withOpacity(.8)),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
    );
  }
}














