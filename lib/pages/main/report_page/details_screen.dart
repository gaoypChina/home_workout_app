
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';


class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    setState(() {
      //controller.jumpTo(12);
    });
    super.initState();
  }

  List<bool> isDone = [];

  @override
  Widget build(BuildContext context) {
    int indexAt = 10;
    var size = MediaQuery.of(context).size;
    String restart = "";
    Timer(
        Duration(seconds: 1),
        () => controller.animateTo(indexAt * size.height * .13 / 1.2,
            duration: Duration(seconds: 1), curve: Curves.easeIn));
    return Scaffold(
      appBar:  AppBar(

        leading: FlatButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          FlatButton(
            child: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          "Complete Body",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ),

      body: Stack(
        children: <Widget>[
          Container(
         //   color: Colors.blue,
            child: SvgPicture.asset(
              'assets/background-vector/undraw_winners_ao2o.svg',
              alignment: Alignment.center,
             color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*.4,
            ),
          ),
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Colors.transparent,
              // image: DecorationImage(
              //   colorFilter:ColorFilter.mode(Colors.blue, BlendMode.screen),
              //   image: AssetImage("assets/background-vector/undraw_winners_ao2o.png"),
              //   fit: BoxFit.fitWidth,
              // ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           InkWell(
                    //               onTap: () => Navigator.of(context).pop(),
                    //               child: CircleAvatar(
                    //                   backgroundColor: Colors.transparent,
                    //                   child: Icon(
                    //                     Icons.arrow_back,
                    //                     color: Colors.black,
                    //                   ))),
                    //           Text(
                    //             "30 day Challenge",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .headline6
                    //                 .copyWith(fontWeight: FontWeight.w900),
                    //           ),
                    //
                    // InkWell(
                    //               onTap: () {
                    //               },
                    //               child: CircleAvatar(
                    //                   backgroundColor: Colors.transparent,
                    //                   child: Icon(
                    //                     Icons.more_vert,
                    //                     color: Colors.black,
                    //                   ))),
                    //         ],
                    //       ),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      "3-10 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                      ),
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: size.height * .68,
                      width: double.infinity,
                      child: GridView.builder(
                          controller: controller,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2,
                                  childAspectRatio: 2),
                          itemCount: 28,
                          itemBuilder: (context, index) {
                            return SeassionCard(
                              seassionNum: index + 1,
                              isDone: isDone[index],
                              press: () {},
                            );
                          }),
                    ),
                    SizedBox(height: 120),
                    Text(
                      "Meditation",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 20),
                    //   padding: EdgeInsets.all(10),
                    //   height: 90,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(13),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         offset: Offset(0, 17),
                    //         blurRadius: 23,
                    //         spreadRadius: -13,
                    //         color: kShadowColor,
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     children: <Widget>[
                    //       SvgPicture.asset(
                    //         "assets/icons/Meditation_women_small.svg",
                    //       ),
                    //       SizedBox(width: 20),
                    //       Expanded(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: <Widget>[
                    //             Text(
                    //               "Basic 2",
                    //               style: Theme.of(context).textTheme.subtitle2,
                    //             ),
                    //             Text("Start your deepen you practice")
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.all(10),
                    //         child: SvgPicture.asset("assets/icons/Lock.svg"),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeassionCard extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;

  const SeassionCard({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 10,
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDone ? Colors.white : Colors.white,

            //color: isDone ? Colors.white :kBlueColor,
            //  shape: BoxShape.circle,
            border: Border.all(color: Colors.blue),

            //Colors.grey.shade200,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: Colors.grey,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              autofocus: true,
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: isDone ? Colors.white : Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Icon(
                        isDone ? Icons.play_arrow : Icons.check,
                        color: isDone ? Colors.blue : Colors.white,
                      ),
                    ),
                    SizedBox(width: 7),
                    Text(
                      "Session $seassionNum",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decoration: isDone
                              ? TextDecoration.none
                              : TextDecoration.lineThrough),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
