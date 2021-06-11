import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/widgets/youtube_player.dart';

import '../helper/text_to_speech.dart';

class MyDialog extends StatefulWidget {
  final List steps;
  final String title;
  final String link;
  final String imgUrl;

  MyDialog({
    @required this.steps,
    @required this.title,
    @required this.imgUrl,
    @required this.link,
  });

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    Speaker _speaker = new Speaker();
    int boxHeight = 4;

    var size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;

    if (widget.steps.length <= 3) {
      boxHeight = 2;
    } else {
      boxHeight = 3;
    }


    return Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
     child: StatefulBuilder(
       builder: (BuildContext context, StateSetter setState){
         return   Container(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Stack(
                 children: [
                   Container(
                     child: Image.asset(
                       widget.imgUrl,
                       fit: BoxFit.scaleDown,
                     ),
                     height: 150,
                     width: 900,
                   ),
                   Positioned(
                     right: 50,
                     top: 15,
                     child: IconButton(
                       icon: Icon(Icons.ondemand_video),
                       onPressed: () {
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                                 builder: (context) => YoutubeTutorial(
                                   link: widget.link,
                                   title: widget.title,
                                   steps: widget.steps,
                                 )));
                       },
                     ),
                   ),
                   Positioned(
                       right: 5,
                       top: 15,
                       child: IconButton(
                           icon: (isActive == true)
                               ? Icon(Icons.volume_off_outlined):Icon(Icons.volume_up_outlined),
                           onPressed: (){
                             print(isActive);
                             isActive = !isActive;
                             isActive == true
                                 ?_speaker.speak(widget.steps.toString()) :_speaker.stop();
                           }
                       )
                   )
                 ],
               ),
               Padding(
                 padding: EdgeInsets.all(10),
                 child: Text(
                   widget.title,
                   style: textTheme.headline2.copyWith(fontWeight: FontWeight.w700,fontSize: 18),
                 ),
               ),
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.blue,
                 ),
                 height: boxHeight * 100.0,
                 width: size.width * .9,
                 child:
                 ListView.builder(
                     itemCount: widget.steps.length,
                     itemBuilder: (ctx, i) {
                       return ListTile(
                           title:
                           Text.rich(
                               TextSpan(
                                   text:  "Step ${i + 1}: ", style:textTheme.caption.copyWith(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.white),
                                   children: <InlineSpan>[
                                     TextSpan(
                                         text:
                                         widget.steps[i],
                                         style:textTheme.caption.copyWith(fontSize: 14,color:(isActive == true)
                                             ? Colors.grey:Colors.yellow
                                         )),

                                   ]

                                 // Text(
                                 //
                               )));
                     }),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   ElevatedButton(
                       child: Text('Close'),
                       style: ElevatedButton.styleFrom(
                       ),
                       onPressed: () {
                         isActive = false;
                         _speaker.stop();
                         Navigator.of(context).pop();
                       })
                 ],
               ),
             ],
           ),
         );
       }
     ),
    //   actions: [
    //     if (orientation == Orientation.portrait)
    //       Container(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Stack(
    //               children: [
    //                 Container(
    //                   child: Image.asset(
    //                     widget.imgUrl,
    //                     fit: BoxFit.scaleDown,
    //                   ),
    //                   height: 150,
    //                   width: 900,
    //                 ),
    //                 Positioned(
    //                   right: 50,
    //                   top: 15,
    //                   child: IconButton(
    //                     icon: Icon(Icons.ondemand_video),
    //                     onPressed: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => YoutubeTutorial(
    //                                     link: widget.link,
    //                                     title: widget.title,
    //                                 steps: widget.steps,
    //                                   )));
    //                     },
    //                   ),
    //                 ),
    //                 Positioned(
    //                     right: 5,
    //                     top: 15,
    //                     child: IconButton(
    //                             icon: (isActive == true)
    //                                 ? Icon(Icons.volume_off_outlined):Icon(Icons.volume_up_outlined),
    //                             onPressed: (){
    //                               print(isActive);
    //                               isActive = !isActive;
    //                                isActive == true
    //                                   ?_speaker.speak(widget.steps.toString()) :_speaker.stop();
    //                                  }
    //                                 )
    //                        )
    //               ],
    //             ),
    //             Padding(
    //               padding: EdgeInsets.all(10),
    //               child: Text(
    //                 widget.title,
    //                 style: textTheme.headline2.copyWith(fontWeight: FontWeight.w700,fontSize: 18),
    //               ),
    //             ),
    //             Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: Colors.blue,
    //               ),
    //               height: boxHeight * 100.0,
    //               width: size.width * .9,
    //               child:
    //               ListView.builder(
    //                   itemCount: widget.steps.length,
    //                   itemBuilder: (ctx, i) {
    //                     return ListTile(
    //                       title:
    //                         Text.rich(
    //                         TextSpan(
    //                         text:  "Step ${i + 1}: ", style:textTheme.caption.copyWith(fontSize: 15,fontWeight: FontWeight.w700,color: Colors.white),
    //                             children: <InlineSpan>[
    //                         TextSpan(
    //                         text:
    //                         widget.steps[i],
    //                             style:textTheme.caption.copyWith(fontSize: 14,color:(isActive == true)
    // ? Colors.grey:Colors.yellow
    //                           )),
    //
    //                     ]
    //
    //                       // Text(
    //                       //
    //                     )));
    //                   }),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 ElevatedButton(
    //                     child: Text('Close'),
    //                     style: ElevatedButton.styleFrom(
    //                     ),
    //                     onPressed: () {
    //                       isActive = false;
    //                       _speaker.stop();
    //                       Navigator.of(context).pop();
    //                     })
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     if (Orientation.landscape == orientation)
    //       Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Stack(
    //                   children: [
    //                     Container(
    //                       child: Image.asset(
    //                         widget.imgUrl,
    //                         fit: BoxFit.scaleDown,
    //                       ),
    //                       height: size.height * .4,
    //                       width: 300,
    //                     ),
    //                     Positioned(
    //                       right: 50,
    //                       top: 15,
    //                       child: IconButton(
    //                         icon: Icon(Icons.ondemand_video),
    //                         onPressed: () {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) => YoutubeTutorial(
    //                                         link: widget.link,
    //                                         title: widget.title,
    //                                         steps: widget.steps
    //                                       )));
    //                         },
    //                       ),
    //                     ),
    //                     Positioned(
    //                         right: 5,
    //                         top: 15,
    //                         child: isActive == true
    //                             ? IconButton(
    //                                 icon: Icon(Icons.volume_off_outlined),
    //                                 onPressed: () => {
    //                                       setState(() {
    //                                         isActive = false;
    //                                       }),
    //                                       _speaker.stop(),
    //                                     })
    //                             : IconButton(
    //                                 icon: Icon(Icons.volume_up),
    //                                 onPressed: () => {
    //                                       setState(() {
    //                                         isActive = true;
    //                                       }),
    //                                       _speaker.speak(
    //                                         widget.steps.toString(),
    //                                       ),
    //                                     }))
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.all(10),
    //                   child: Text(
    //                     widget.title,
    //                     style: TextStyle(
    //                       fontWeight: FontWeight.w600,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               crossAxisAlignment: CrossAxisAlignment.end,
    //               children: [
    //                 Container(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     color: Colors.blue,
    //                   ),
    //                   height: size.height * .6,
    //                   width: size.width * .4,
    //                   child: ListView.builder(
    //                       itemCount: widget.steps.length,
    //                       itemBuilder: (ctx, i) {
    //                         return ListTile(
    //                           title: Text(
    //                             widget.steps[i],
    //                             style: GoogleFonts.martel(
    //                                 wordSpacing: 5, fontSize: 12),
    //                           ),
    //                         );
    //                       }),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     RaisedButton(
    //                         child: Text('got it !'),
    //                         color: Colors.red,
    //                         onPressed: () {
    //                           isActive = false;
    //                           _speaker.stop();
    //                           Navigator.of(context).pop();
    //                         })
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //   ],
    );
  }
}
