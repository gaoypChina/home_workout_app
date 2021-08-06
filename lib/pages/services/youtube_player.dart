import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../main.dart';

class YoutubeTutorial extends StatefulWidget {
  final Workout workout;
  final int rapCount;

  const YoutubeTutorial({@required this.workout, @required this.rapCount});

  @override
  _YoutubeTutorialState createState() => _YoutubeTutorialState();
}

class _YoutubeTutorialState extends State<YoutubeTutorial> {

  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.workout.videoLink));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTopBar() {
      return Container(

        padding: EdgeInsets.only(top: 10),
        height: 50,
        child:             TextButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          label: Text(""),
        ),

      );
    }

    getImage(Workout workout, double height, double width) {
      return Container(
        height: height * .3,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 1
            ),
            borderRadius: BorderRadius.all(Radius.circular(12))),

        margin: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)) ,
          child: YoutubePlayer(
            bufferIndicator: CircularProgressIndicator(),
            bottomActions: [
              Container(
                color: Colors.red,
              )
            ],
            controller: _controller,
            showVideoProgressIndicator: true,
            liveUIColor: Colors.blue,
            progressColors: ProgressBarColors(backgroundColor: Colors.white,bufferedColor: Colors.white,handleColor: Colors.white,playedColor: Colors.blue),
            controlsTimeOut: Duration(seconds: 10),
          ),
        ),
      );
    }

    getTitle(Workout workout) {
      String rap = workout.showTimer == true
          ? "${widget.rapCount}s"
          : "X ${widget.rapCount}";
      return Container(
        height: 50,
        child: Row(
          children: [
            Text(
              "${workout.title} $rap",
              style: textTheme.bodyText1.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
      );
    }

    getSteps(Workout workout) {
      return Expanded(
          child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              minVerticalPadding: 0,
              leading: Text("Step ${index + 1}: ",
                  style: textTheme.bodyText2.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              title: Text(
                "${workout.steps[index]}",
                style: textTheme.bodyText2
                    .copyWith(color: Colors.white, fontSize: 14),
              ));
        },
        itemCount: workout.steps.length,
      ));
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;


    return Scaffold(
      backgroundColor:isDark?Colors.black: Colors.blue,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTopBar(),
                getImage(widget.workout, height, width),
                getTitle(widget.workout),
                getSteps(widget.workout)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
