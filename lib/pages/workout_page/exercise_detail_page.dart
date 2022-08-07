import 'package:flutter/material.dart';
import '../../database/workout_list.dart';
import '../../pages/services/youtube_service/youtube_player.dart';
import '../../widgets/banner_regular_ad.dart';

class DetailPage extends StatelessWidget {
  final Workout workout;
  final int rapCount;

  DetailPage({required this.workout, required this.rapCount});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    getImage(Workout workout, double height, double width) {
      return Container(
        height: height * .32,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        width: width,
        margin: EdgeInsets.all(8),
        child: Image.asset(
          workout.imageSrc,
          fit: BoxFit.scaleDown,
        ),
      );
    }

    getTitle(Workout workout) {
      String rap = workout.showTimer == true ? "${rapCount}s" : "X $rapCount";
      return Container(
        padding: EdgeInsets.only(left: 18, bottom: 0, top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${workout.title} $rap",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    getSteps(Workout workout) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              minVerticalPadding: 0,
              leading: Text("Step ${index + 1}: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              title: Text(
                "${workout.steps[index]}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    height: 1.5),
              ));
        },
        itemCount: workout.steps.length,
      );
    }

    return Scaffold(
      bottomNavigationBar: Container(height: 60, child: RegularBannerAd()),
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          workout.title,
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor:
            isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.blue,
        leading: TextButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          label: Text(""),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YoutubeTutorial(
                        rapCount: rapCount,
                        workout: workout,
                      ),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  maximumSize: Size(150, 40),
                  primary: isDark ? Colors.grey.shade200 : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 4)),
              child: Text(
                "Video".toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0
                    //   color: Colors.grey.shade800,
                    ),
              ),
            ),
          )
        ],
      ),
      backgroundColor:
          isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            getImage(workout, height, width),
            getTitle(workout),
            getSteps(workout),
            SizedBox(
              height: 88,
            ),
          ],
        ),
      ),
    );
  }
}
