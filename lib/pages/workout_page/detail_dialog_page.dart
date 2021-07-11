import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/database/workout_list.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/widgets/info_button.dart';
import 'package:full_workout/pages/services/youtube_player.dart';

class MyDialog extends StatefulWidget {
  final List<Workout> workoutList;
  final int index;

  MyDialog({@required this.workoutList, this.index});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: widget.index);

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

    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 530,
            width: 40,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
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
                                    child: Image.asset(
                                      item[index].imageSrc,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  height: 150,
                                ),
                                Container(
                                  height: 150,
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
                                                  link: item[index].videoLink,
                                                  title: item[index].title,
                                                  steps: item[index].steps,
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                height: boxHeight * 80.0,
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
                                                color: Colors.black54),
                                            children: <InlineSpan>[
                                          TextSpan(
                                              text: item[index].steps[i],
                                              style: textTheme.caption.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black45)),
                                        ])));
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider();
                                  },
                                ),
                              ),
                            ),
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
                  height: 50,
                  color: Colors.blue.shade800,
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
        }));
  }
}
