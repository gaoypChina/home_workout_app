import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/workout_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController tabController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }



  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    getTitle(String title){
      return Padding(
        padding: EdgeInsets.only(left: 12,right: 12,top: 24,bottom: 6),
        child: Text(title,style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,fontSize: 18),),
      );
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor:
          isShrink ? Colors.white : Colors.blue,

          body:
          SafeArea(
              child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 10,
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  expandedHeight: 190.0,
                    collapsedHeight: 60,
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: isShrink ? Colors.white : Colors.blue,

                  title: Text("Home Workout",
                      style: textTheme.headline1.copyWith(
                          fontSize: 22,
                          color: Colors.black,

                          fontWeight: FontWeight.bold,
                          letterSpacing: -1)),
                  //collapsedHeight: 55,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Container(
                            child: Achievement(
                              timeTitle: "Time",
                              timeValue: 12,
                              caloriesTitle: "Calories",
                              caloriesValue: 14,
                              exerciseTitle: "Exercise",
                              exerciseValue: 16,
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(""),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)
                                        // bottomLeft: Radius.circular(40),
                                        // bottomRight: Radius.circular(40))
                                        )),
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ];
            },
            body: Scaffold(
              body: TabBarView(
                controller: tabController,
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      getTitle(exerciseName[0]),
                      for(int i=0; i<3; i++)
                        WorkoutCard(title: absExercise[i].title, workoutList: absExercise[i].workoutList, star: i, imaUrl: absExercise[i].imageUrl,tag:  absExercise[i].tag,),

                      getTitle(exerciseName[1]),
                      for(int i=0; i<3; i++)
                      WorkoutCard(title: chestExercise[i].title, workoutList: chestExercise[i].workoutList, star: i, imaUrl: chestExercise[i].imageUrl,tag: chestExercise[i].tag,),

                      getTitle(exerciseName[2]),
                      for(int i=0; i<3; i++)
                        WorkoutCard(title: shoulderExercise[i].title, workoutList: shoulderExercise[i].workoutList, star: i, imaUrl: shoulderExercise[i].imageUrl,tag: shoulderExercise[i].tag,),

                      getTitle(exerciseName[3]),
                      for(int i=0; i<3; i++)
                        WorkoutCard(title: legsExercise[i].title, workoutList: legsExercise[i].workoutList, star: i, imaUrl: legsExercise[i].imageUrl,tag:legsExercise[i].tag ,),

                      getTitle(exerciseName[4]),
                      for(int i=0; i<3; i++)
                        WorkoutCard(title: armsExercise[i].title, workoutList: armsExercise[i].workoutList, star: i, imaUrl: armsExercise[i].imageUrl,tag: armsExercise[i].tag,),
                    ],
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
