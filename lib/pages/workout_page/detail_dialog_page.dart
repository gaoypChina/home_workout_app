import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/components/info_button.dart';
import 'package:full_workout/pages/services/youtube_player.dart';

import '../../main.dart';

class MyDialog extends StatefulWidget {
  final List<Workout> workoutList;
  final int rapCount;
  final int index;

  MyDialog({@required this.workoutList, this.index,@required this.rapCount});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: widget.index);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int boxHeight = 3;

    int currPage = widget.index;

    var item = widget.workoutList;

    _onLeftAction(StateSetter setState) {
      if (currPage > 0) {
        setState(() {
          currPage--;
        });
        _controller.animateToPage(currPage,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    }

    _onRightAction(StateSetter setState) {
      if (currPage < item.length - 1) {
        setState(() {
          currPage++;
        });
        _controller.animateToPage(currPage,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    }



    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context,true);
        return Future.value(true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width*.07,vertical: height*.13),
          decoration: BoxDecoration(color: Colors.black45),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(16))),

              child: Column(
                children: [
                  Expanded(
                    child:
                    PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: item.length,
                        controller: _controller,
                        itemBuilder: (context, index) {
                          currPage = index;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    child: Center(
                                      child: Hero(
                                        tag:item[index].title,
                                        child: Image.asset(
                                          item[index].imageSrc,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    height: height *.2,
                                  ),
                                  Container(
                                    height:height *.2,
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(.05),
                                  ),
                                  Positioned(
                                      right: 10,
                                      top: 10,
                                      child: InfoButton(
                                          tooltip: "Video",
                                          icon: Icons.ondemand_video,
                                          onPress: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      YoutubeTutorial(
                                                        rapCount:widget.rapCount ,
                                                    workout: widget.workoutList[widget.index],
                                                  ),
                                                ));
                                          })),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 10, bottom: 10),
                                child: Text(
                                  item[index].title,
                                  style: textTheme.headline2.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                height: height*.32,
                                child: ListView.separated(
                                  padding: EdgeInsets.only(bottom: 8),
                                  itemCount: item[index].steps.length,
                                  itemBuilder: (ctx, i) {
                                    return Container(
                                        child: Text.rich(TextSpan(
                                            text: "Step ${i + 1}: ",
                                            style: textTheme.caption.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black87),
                                            children: <InlineSpan>[
                                          TextSpan(
                                              text: item[index].steps[i],
                                              style: textTheme.caption.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.grey.shade800)),
                                        ])));
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: Text("Close"),
                                ),
                                  SizedBox(width: 10,)
                              ],)
                            ],
                          );
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(16),bottomLeft:Radius.circular(16))
                    ),
                    height: 50,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _onLeftAction(setState);
                            },
                            icon: Icon(
                              FontAwesome.step_backward,
                              color: (currPage > 0)
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            )),
                        Container(
                          
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${currPage + 1} / ",
                                style: textTheme.bodyText1.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${item.length}",
                                style: textTheme.bodyText1
                                    .copyWith(color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              _onRightAction(setState);
                            },
                            icon: Icon(
                              FontAwesome.step_forward,
                              color: (currPage < item.length - 1)
                                  ? Colors.white
                                  : Colors.grey.shade500,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
