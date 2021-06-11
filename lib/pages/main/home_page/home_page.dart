import 'package:flutter/material.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import 'package:full_workout/widgets/achivement.dart';
import 'package:full_workout/widgets/workout_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController tabController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    tabController = new TabController(
      vsync: this,
      length: 1,
    );
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }



  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    List<String> bodyPart = ["Abs", "Chest", "Shoulder", "Legs", "Arms"];
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    List<String> cover = [
      "assets/bg_cover/abs-cover.png",
      "assets/cover/chest.jpg",
      "assets/bg_cover/back-cover.png",
      "assets/cover/leg-cover.jpg",
      "assets/cover/arm-cover.jpg",
    ];

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: isShrink ? Colors.white : Colors.blue,

          body:
          SafeArea(
              child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 10,
                  automaticallyImplyLeading: false,
                  centerTitle: false,
                  expandedHeight: 190.0,
                    collapsedHeight: 60,
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: isShrink ? Colors.white : Colors.blue,

                  title: Text("Home Workout",
                      style: textTheme.headline1.copyWith(
                          fontSize: 22,
                          color: Colors.black,

                          fontWeight: FontWeight.bold,
                          letterSpacing: -1)),
                  //collapsedHeight: 55,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Container(
                            child: Achievement(
                              timeTitle: "Time",
                              timeValue: 12,
                              caloriesTitle: "Calories",
                              caloriesValue: 14,
                              exerciseTitle: "Exercise",
                              exerciseValue: 16,
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(""),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)
                                        // bottomLeft: Radius.circular(40),
                                        // bottomRight: Radius.circular(40))
                                        )),
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ];
            },
            body: Scaffold(
              body: TabBarView(
                controller: tabController,
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return WorkOutCard(
                        title: bodyPart[index],
                        image: cover[index],
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: bodyPart.length,
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
