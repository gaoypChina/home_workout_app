import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/bloc_provider/connectivity_state_bloc.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../main.dart';

class YoutubeTutorial extends StatefulWidget {
  final Workout workout;
  final int rapCount;

  const YoutubeTutorial({required this.workout, required this.rapCount});

  @override
  _YoutubeTutorialState createState() => _YoutubeTutorialState();
}

class _YoutubeTutorialState extends State<YoutubeTutorial> {

  late YoutubePlayerController _controller;
  bool isConnected = false;
  bool isLoading = true;
  bool loadVideo = true;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.workout.videoLink)??"");
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      isConnected = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getTopBar() {
      return Container(
        padding: EdgeInsets.only(top: 10),
        height: 50,
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          label:Text(""),
        ),

      );
    }

    getImage(Workout workout, double height, double width) {
      return
      BlocBuilder<ConnectivityCubit, ConnectivityState>(builder: (context,state){
        if(state is ConnectivityConnected){
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
        }else{

          Future.delayed(Duration(seconds: 2)).then((value) {
            setState(() {
              loadVideo = false;
            });
          });
          return
            Container(
            height: height * .3,
              width: width,
              decoration: BoxDecoration(
                color: Colors.black,

                  border: Border.all(
                      color: Colors.white,
                      width: 2
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12))),


              margin: EdgeInsets.all(8),
            child:loadVideo?Center(child: CircularProgressIndicator(color: Colors.white,),): Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(FontAwesomeIcons.wifi,color: Colors.white,size: height*.15,),
                Text("No internet Connection found",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                SizedBox(height: 5,),

                Text("Please connect to network to watch video tutorial",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
              ],
            )
          );
        }
      });

    }

    getTitle(Workout workout) {
      String rap = workout.showTimer == true
          ? "${widget.rapCount}s"
          : "X ${widget.rapCount}";
      return Container(
        height: 60,
        child:
            Text(
              "${workout.title} $rap",
              style: textTheme.bodyText1!.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),

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
                      style: textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  title: Text(
                    "${workout.steps[index]}",
                    style: textTheme.bodyText2
                        !.copyWith(color: Colors.white, fontSize: 14),
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
