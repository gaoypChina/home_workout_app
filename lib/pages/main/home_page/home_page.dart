import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/models/main_page_item.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/workout_card.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   ScrollController _scrollController;
//   TabController tabController;
//
//   bool lastStatus = true;
//
//   _scrollListener() {
//     if (isShrink != lastStatus) {
//       setState(() {
//         lastStatus = isShrink;
//       });
//     }
//   }
//
//   bool get isShrink {
//     return _scrollController.hasClients &&
//         _scrollController.offset > (200 - kToolbarHeight);
//   }
//
//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     tabController = new TabController(
//       vsync: this,
//       length: 1,
//     );
//     _scrollController.addListener(_scrollListener);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     super.dispose();
//   }
//
//
//
//   Future<bool> _onBackPressed() {
//     return showDialog(
//           context: context,
//           builder: (context) => new AlertDialog(
//             title: new Text('Are you sure?'),
//             content: new Text('Do you want to exit an App'),
//             actions: <Widget>[
//               new GestureDetector(
//                 onTap: () => Navigator.of(context).pop(false),
//                 child: Text("NO"),
//               ),
//               SizedBox(height: 16),
//               new GestureDetector(
//                 onTap: () => Navigator.of(context).pop(true),
//                 child: Text("YES"),
//               ),
//             ],
//           ),
//         ) ??
//         false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     getTitle(String title){
//       return Container(
//         padding: EdgeInsets.only(left: 18,right: 12,top: 12,bottom: 6),
//         child: Text(title.toUpperCase(),style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,fontSize: 15,)),
//       );
//     }
//
//     return WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Scaffold(
//           backgroundColor:
//           isShrink ? Colors.white : Colors.blue,
//
//           body:
//           SafeArea(
//               child: NestedScrollView(
//             controller: _scrollController,
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   elevation: 20,
//                   automaticallyImplyLeading: false,
//                   centerTitle: false,
//               //   expandedHeight: 181.0,
//                     collapsedHeight: 60,
//                   pinned: true,
//                   floating: false,actions: [
//                     IconButton(onPressed: (){}, icon: Icon(FontAwesome.calendar,),color: Colors.blue,padding: EdgeInsets.only(right: 8),tooltip: "History",),
//
// ],
//                   forceElevated: innerBoxIsScrolled,
//                   backgroundColor: isShrink ? Colors.white : Colors.white,
//
//                   title: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(text: "Home ",
//                         style: textTheme.headline6.copyWith(color:Colors.blue)),
//                         TextSpan(text: "Workout",
//                             style: textTheme.headline6.copyWith(color:Colors.black))
//
//
//                       ]
//                     )
//                   ),
//                   //collapsedHeight: 55,
//
//                   // flexibleSpace: FlexibleSpaceBar(
//                   //   background: Stack(children: <Widget>[
//                   //     Column(
//                   //       children: [
//                   //         Container(
//                   //           height: 60,
//                   //         ),
//                   //
//                   //            Container(
//                   //             margin: EdgeInsets.only(left: 8,right: 8),
//                   //             child: Material(
//                   //               elevation: 0,
//                   //               color: Colors.blue,
//                   //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
//                   //               child: Achievement(
//                   //                 timeTitle: "Time",
//                   //                 timeValue: 12,
//                   //                 caloriesTitle: "Calories",
//                   //                 caloriesValue: 14,
//                   //                 exerciseTitle: "Exercise",
//                   //                 exerciseValue: 16,
//                   //               ),
//                   //             ),
//                   //           //  height: MediaQuery.of(context).size.height / 5,
//                   //           ),
//                   //
//                   //       ],
//                   //     )
//                   //   ]),
//                   // ),
//                 )
//               ];
//             },
//             body: Scaffold(
//
//               body: TabBarView(
//                 controller: tabController,
//                 children: [
//                   ListView(
//                     physics: BouncingScrollPhysics(),
//                     children: [
//                       SizedBox(height: 10,),
//                       Container(
//                         margin: EdgeInsets.only(left: 8,right: 8),
//                         child: Achievement(
//                           timeTitle: "Time",
//                           timeValue: 12,
//                           caloriesTitle: "Calories",
//                           caloriesValue: 14,
//                           exerciseTitle: "Exercise",
//                           exerciseValue: 16,
//                         ),
//                      decoration: BoxDecoration(
//                        color: Colors.blue,
//                          borderRadius: BorderRadius.all(Radius.circular(20)),
//                        gradient: new LinearGradient(
//                            colors: [
//                               Colors.blue,
//                               Colors.blue.shade300,
//                            ],
//                            begin: const FractionalOffset(0.0, 0.0),
//                            end: const FractionalOffset(1.0, 0.0),
//                            stops: [0.0, 1.0],
//                            tileMode: TileMode.clamp),
//                          boxShadow: [BoxShadow(
//                            color: Colors.grey,
//                            blurRadius: 5.0,
//                          ),]
//
//                      ),
//                      //   height: MediaQuery.of(context).size.height / 5,
//                       ),
//                       SizedBox(height: 10,),
//                       getTitle(exerciseName[0]),
//                       for(int i=0; i<3; i++)
//                         WorkoutCard(title: absExercise[i].title, workoutList: absExercise[i].workoutList, star: i, imaUrl: absExercise[i].imageUrl,tag:  absExercise[i].tag,),
//
//                       getTitle(exerciseName[1]),
//                       for(int i=0; i<3; i++)
//                       WorkoutCard(title: chestExercise[i].title, workoutList: chestExercise[i].workoutList, star: i, imaUrl: chestExercise[i].imageUrl,tag: chestExercise[i].tag,),
//
//                       getTitle(exerciseName[2]),
//                       for(int i=0; i<3; i++)
//                         WorkoutCard(title: shoulderExercise[i].title, workoutList: shoulderExercise[i].workoutList, star: i, imaUrl: shoulderExercise[i].imageUrl,tag: shoulderExercise[i].tag,),
//
//                       getTitle(exerciseName[3]),
//                       for(int i=0; i<3; i++)
//                         WorkoutCard(title: legsExercise[i].title, workoutList: legsExercise[i].workoutList, star: i, imaUrl: legsExercise[i].imageUrl,tag:legsExercise[i].tag ,),
//
//                       getTitle(exerciseName[4]),
//                       for(int i=0; i<3; i++)
//                         WorkoutCard(title: armsExercise[i].title, workoutList: armsExercise[i].workoutList, star: i, imaUrl: armsExercise[i].imageUrl,tag: armsExercise[i].tag,),
//                       SizedBox(height: 20,)
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )),
//         ));
//   }
// }

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit Home Workout App'),
          actions: <Widget>[


            new TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),

            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
          ],
        ))??
       false;}
    getTitle(String title){
      return Container(
        padding: EdgeInsets.only(left: 18,right: 12,top: 12,bottom: 6),
        child: Text(title.toUpperCase(),style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w600,fontSize: 15,)),
      );
    }
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Home ",
                          style: textTheme.headline6.copyWith(color:Colors.blue)),
                          TextSpan(text: "Workout",
                              style: textTheme.headline6.copyWith(color:Colors.amber))


                        ]
                      )
                    ),
            actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesome.calendar,
              ),
              color: Colors.blue,
              tooltip: "History",
            ),
          ],
        ),
        body:
      ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          margin: EdgeInsets.only(left: 8,right: 8),
                          child: Achievement(
                            timeTitle: "Time",
                            timeValue: 12,
                            caloriesTitle: "Calories",
                            caloriesValue: 14,
                            exerciseTitle: "Exercise",
                            exerciseValue: 16,
                          ),
                       decoration: BoxDecoration(
                         color: Colors.blue,
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                         gradient: new LinearGradient(
                             colors: [
                                Colors.blue,
                                Colors.blue,
                             ],
                             begin: const FractionalOffset(0.0, 0.0),
                             end: const FractionalOffset(1.0, 0.0),
                             stops: [0.0, 1.0],
                             tileMode: TileMode.clamp),
                           boxShadow: [BoxShadow(
                             color: Colors.grey,
                             blurRadius: 5.0,
                           ),]

                       ),
                       //   height: MediaQuery.of(context).size.height / 5,
                        ),
                        SizedBox(height: 10,),

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
                        SizedBox(height: 20,)
                      ],
                    )



      ),
    );
  }
}
