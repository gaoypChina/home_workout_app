import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/widgets/timer.dart';

import '../main.dart';

class Demo extends StatefulWidget {

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin{
  AnimationController controller;
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int get timerValue {
    Duration duration = controller.duration * controller.value;
    return duration.inMilliseconds;

    //duration.inSeconds % 60;
  }
 bool isAnimating = true;

  _onComplete() {

    setState(() {
      isAnimating = false;
    });

  }



  @override
  void dispose() {
    controller.dispose();
    // flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    print(AnimationStatus.values);

    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 35),
    );

    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.dismissed) {
         _onComplete();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget getTimer() {
      return
      isAnimating?

      Column(
        children: [

          Center(
              child:Container (
              height: 150,
              width: 150,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return CustomPaint(
                              painter: TimerPainter(
                                animation: controller,
                                backgroundColor: Color(0xff00D9F6),
                                color: Colors.blue,
                                //Color(0xff1F2633),
                              ));
                        },
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AnimatedBuilder(
                              animation: controller,
                              builder:
                                  (BuildContext context, Widget child) {

                                return Text(
                                  '0 : ${timerValue ~/ 1000}',
                                  style: textTheme.subtitle1.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,color: Colors.blue.shade700,),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
            ),
        ],
      ):Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        ElevatedButton(onPressed: (){}, child: Text("Share My Profile")),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){}, child: Text("Match Request"))
      ],),);
    }
    return Scaffold(
      backgroundColor:
          Colors.white,
      //Colors.black,
    //  Color(0xff131926),
      body: SingleChildScrollView(

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AnimatedBackground(
            behaviour: RandomParticleBehaviour(options: ParticleOptions(spawnMaxSpeed: 100,spawnMinSpeed: 50,baseColor: Colors.blue.shade700)),
            vsync: this,
            child: getTimer(),
          ),
        ),
      ),
    );
  }
}
