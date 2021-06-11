import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../main.dart';

class YoutubeTutorial extends StatefulWidget {
  final String link;
  final String title;
  final List<String>steps;
  const YoutubeTutorial({
    @required this.link,
    @required this.title,
    @required this.steps
  });

  @override
  _YoutubeTutorialState createState() => _YoutubeTutorialState();
}

class _YoutubeTutorialState extends State<YoutubeTutorial> {
  String videoURL = "https://www.youtube.com/watch?v=n8X9_MgEdCg";

  YoutubePlayerController _controller;

  @override
  void initState() {
    print(widget.steps.toString());
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.link));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(bufferIndicator: CircularProgressIndicator(),
                bottomActions: [Container(height: height*.3,color: Colors.blue,)],
                controller: _controller,
                showVideoProgressIndicator: true,
                controlsTimeOut: Duration(seconds: 30),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 18,bottom: 8),
              child: Text("Steps",style: textTheme.subtitle2.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
            ),
            Container(height:height*.45 ,
                child:
            ListView.builder(
                itemCount: widget.steps.length,
                itemBuilder: (ctx, i) {
                  return ListTile(
                      title:
                      Text.rich(
                          TextSpan(
                              text:  "Step ${i + 1}: ", style:textTheme.caption.copyWith(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black),
                              children: <InlineSpan>[
                                TextSpan(
                                    text:
                                    widget.steps[i],
                                    style:textTheme.caption.copyWith(fontSize: 14,color: Colors.black)
                                ),

                              ]

                            // Text(
                            //
                          )));
                }))
            ],
          ),
        ),

      ),
    );
  }
}
