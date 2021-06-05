import 'dart:async';

import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/models/onboarding_item.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<OnBoardingItem> onBoardingList = [
    OnBoardingItem(
        color: Colors.white,
        title: "No pain, no gain.",
        desc: "If you want something you’ve never had, you must be willing to do something you’ve never done",
        image: "assets/splash/img1.png"),
    OnBoardingItem(
        color: Colors.white,
        title: "Easy to Use",
        desc: "Sometimes you don’t realize your own strength until you come face to face with your greatest weakness",
        image: "assets/splash/img2.png"),
    OnBoardingItem(
        color: Colors.white,
        title: "Interact Around The World",
        desc: "The difference between the impossible and the possible lies in a person’s determination",
        image: "assets/splash/img2.png"),
  ];
  int pageIndex = 0;
  PageController pageController;
  Timer timer;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
    timer = Timer.periodic(Duration(seconds:4), (timer){
      var pos = (pageIndex+1)%onBoardingList.length;
      pageController.animateToPage(pos, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView.builder(
                controller: pageController,
                onPageChanged: (position) {
                  setState(() {
                    pageIndex = position;
                  });
                },
                itemCount: onBoardingList.length,
                itemBuilder: (context, position) {
                  final item = onBoardingList[position];
                  return Column(
                    children: [
                      Expanded(child: Image.asset(item.image)),
                      Text(item.title, style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontSize: 22))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: Text(item.desc, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(height: 1.4, fontSize: 15, color: Colors.grey.shade500)), textAlign: TextAlign.center,),
                      ),
                    ],
                  );
                })
        ),
        Container(
          height: 16,
          child: ListView.builder(
              itemCount: onBoardingList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, position) {
                return AnimatedContainer(
                  height: 16,
                  width: 16,
                  margin: EdgeInsets.all(5),
                  duration: Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: pageIndex == position
                          ? Constants.primaryColor
                          : Theme.of(context).primaryColorLight),
                );
              }),
        )
      ],
    );
  }

  @override
  void dispose() {
    if(timer!=null) timer.cancel();
    if(pageController!=null) pageController.dispose();
    super.dispose();
  }

}