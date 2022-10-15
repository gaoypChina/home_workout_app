import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../bloc_provider/connectivity_state_bloc.dart';
import '../../../database/workout_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../widgets/banner_regular_ad.dart';

class YoutubeTutorial extends StatefulWidget {
  final Workout workout;

  const YoutubeTutorial({required this.workout});

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
        initialVideoId:
            YoutubePlayer.convertUrlToId(widget.workout.videoLink) ?? "");
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
    getTitle(Workout workout) {

      return  Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text(
            "${workout.title}",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white
            )),
      );
    }
    getTopBar() {
      return Container(
        padding: EdgeInsets.only(top: 10),
        height: 50,
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          label:  getTitle(widget.workout),
        ),
      );
    }

    getImage(Workout workout, double height, double width) {
      return BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
        if (state is ConnectivityConnected) {
          return Container(
            height: height * .3,
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
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
                progressColors: ProgressBarColors(
                    backgroundColor: Colors.white,
                    bufferedColor: Colors.white,
                    handleColor: Colors.white,
                    playedColor: Colors.blue),
                controlsTimeOut: Duration(seconds: 10),
              ),
            ),
          );
        } else {
          Future.delayed(Duration(seconds: 2)).then((value) {
            setState(() {
              loadVideo = false;
            });
          });
          return Container(
              height: height * .3,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.all(8),
              child: loadVideo
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.wifi,
                          color: Colors.white,
                          size: height * .15,
                        ),
                        Text(
                          "No internet Connection found",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Please connect to network to watch video tutorial",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ));
        }
      });
    }



    getSteps(Workout workout) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              minVerticalPadding: 12,
              leading: Text("Step ${index + 1}: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).textTheme.bodyText1!.color == Colors.white;

    return Scaffold(
      bottomNavigationBar: Container(height: 60, child: RegularBannerAd()),
      backgroundColor:
          isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTopBar(),
                getImage(widget.workout, height, width),
                getSteps(widget.workout)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
