import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constants/app_theme.dart';
import '../../../database/workout_list.dart';
import '../../../provider/connectivity_provider.dart';
import '../../../widgets/banner_regular_ad.dart';

class YoutubeTutorial extends StatefulWidget {
  final Workout workout;

  const YoutubeTutorial({super.key, required this.workout});

  @override
  YoutubeTutorialState createState() => YoutubeTutorialState();
}

class YoutubeTutorialState extends State<YoutubeTutorial> {
  late YoutubePlayerController _controller;
  bool isConnected = false;
  bool isLoading = true;


  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
        YoutubePlayer.convertUrlToId(widget.workout.videoLink) ?? "");
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() async {
    var connectivityProvider =
    Provider.of<ConnectivityProvider>(context, listen: false);
    isConnected = await connectivityProvider.isNetworkConnected;

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
            workout.title,
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
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          label:  getTitle(widget.workout),
        ),
      );
    }

    getImage(Workout workout, double height, double width) {
      return isConnected
          ? Container(
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
            liveUIColor: Theme.of(context).primaryColor,
            progressColors: ProgressBarColors(
                backgroundColor: Colors.white,
                bufferedColor: Colors.white,
                handleColor: Colors.white,
                playedColor: Theme.of(context).primaryColor
            ),
            controlsTimeOut: Duration(seconds: 10),
          ),
        ),
      )
          : Container(
          height: height * .3,
          width: width,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.wifi,
                color: Colors.white,
                size: height * .1,
              ),
              SizedBox(height: 18,),
              Text(
                "Please connect to Internet",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(onPressed: (){
                checkConnectivity();
              }, child: Text("Retry"))
            ],
          ));
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
                workout.steps[index],
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

    return Scaffold(
      bottomNavigationBar: SizedBox(height: 60, child: RegularBannerAd()),
      backgroundColor:
      darkAppBarColor,
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
