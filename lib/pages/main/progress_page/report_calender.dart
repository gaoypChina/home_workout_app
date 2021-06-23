import 'package:flutter/material.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class CalenderEvent extends StatefulWidget {
  static const routeName = "Calender-Event";
  final Map<DateTime, List> events;
  final List<List<RecentWorkout>> eventList;
  final Set<String> dateSet;

  CalenderEvent(
      {@required this.events,
      @required this.eventList,
      @required this.dateSet});

  @override
  CalenderEventState createState() => CalenderEventState();
}

class CalenderEventState extends State<CalenderEvent>
    with SingleTickerProviderStateMixin {
  //CalendarController _calendarController;
  ScrollController _scrollController;
  TabController tabContoller;

  @override
  void initState() {
  //  _calendarController = CalendarController();
    _scrollController = new ScrollController();
    tabContoller = new TabController(
      vsync: this,
      length: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    //_calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> dateList = widget.dateSet.toList();
    return Scaffold(
      backgroundColor: Colors.red,
        body: SafeArea(
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // SliverAppBar(
            //   expandedHeight: 450.0,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Stack(children: <Widget>[
            //
            //           Container(
            //             height: 350,
            //             child: TableCalendar(
            //               availableCalendarFormats:{CalendarFormat.month : 'Month'} ,
            //               calendarController: _calendarController,
            //               //   initialCalendarFormat: CalendarFormat.week,
            //               startingDayOfWeek: StartingDayOfWeek.monday,
            //               formatAnimation: FormatAnimation.slide,
            //               events: widget.events,
            //               headerStyle: HeaderStyle(
            //                 centerHeaderTitle: true,
            //                 formatButtonVisible: false,
            //                 titleTextStyle:
            //                 TextStyle(color: Colors.white, fontSize: 16),
            //                 leftChevronIcon: Icon(
            //                   Icons.arrow_back_ios,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //                 rightChevronIcon: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: Colors.white,
            //                   size: 15,
            //                 ),
            //                 leftChevronMargin: EdgeInsets.only(left: 70),
            //                 rightChevronMargin: EdgeInsets.only(right: 70),
            //               ),
            //               calendarStyle: CalendarStyle(
            //                   weekendStyle: TextStyle(color: Colors.white),
            //                   weekdayStyle: TextStyle(color: Colors.white)),
            //               daysOfWeekStyle: DaysOfWeekStyle(
            //                   weekendStyle: TextStyle(color: Colors.white),
            //                   weekdayStyle: TextStyle(color: Colors.white)),
            //             ),
            //
            //       )
            //     ]),
            //   ),
            //
            // )
          ];
        },
        body: TabBarView(
          controller: tabContoller,
          children: [
            ListView(
              children: [
                Expanded(
                //  height: 350,
                  child: TableCalendar(
                    calendarFormat: CalendarFormat.month,

                    availableGestures: AvailableGestures.all,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }return Container();
                      },
                    ),
                    availableCalendarFormats: {CalendarFormat.month: 'Month'},
                   // calendarController: _calendarController,
                    //   initialCalendarFormat: CalendarFormat.week,
                    startingDayOfWeek: StartingDayOfWeek.monday,

                   // formatAnimation: FormatAnimation.slide,
                 //   events: widget.events,
                    headerStyle: HeaderStyle(
                  //    centerHeaderTitle: true,
                      formatButtonVisible: false,
                      titleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      leftChevronMargin: EdgeInsets.only(left: 70),
                      rightChevronMargin: EdgeInsets.only(right: 70),
                    ),rowHeight: 40,


                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(color: Colors.white),
                        weekdayStyle: TextStyle(color: Colors.white)),
                  ),),
                Container(
                  height: 380,
                  child: Expanded(
                    child: Card(
                      child: ListView.builder(
                          physics:BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: dateList.length,
                          itemBuilder: (BuildContext context, index) {
                            // var item = widget.eventList[index];
                            return Container(
                                height: 50 + widget.eventList[index].length * 70.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Text(dateList[index],style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
                                    Expanded(
                                        //height: 150,
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: widget.eventList[index].length,
                                            itemBuilder: (c, i) {
                                              var item = widget.eventList[index][i];
                                              return ListTile(
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  child: Image.asset("assets/animated-cover/abs.png"),
                                                ),
                                                title: Text(
                                                    item.workoutTitle),
                                                subtitle: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text("Calories : ${item.calories}"),
                                                    Text("Exercise : ${item.exercise}"),
                                                    Text("Time : ${item.activeTime}")
                                                  ],
                                                ),
                                              );
                                            })),
                                    Divider(height: 1,color: Colors.amber,)
                                  ],
                                ),
                              );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));

    // body: NestedScrollView(
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           title: Text("Event Calendar"),
    //           pinned: true,
    //           expandedHeight: 50,
    //           flexibleSpace: FlexibleSpaceBar(
    //             background: Stack(children: <Widget>[
    //               // Container(
    //               //   height: 350,
    //               //   child: TableCalendar(
    //               //     availableCalendarFormats:{CalendarFormat.month : 'Month'} ,
    //               //     calendarController: _calendarController,
    //               //     //   initialCalendarFormat: CalendarFormat.week,
    //               //     startingDayOfWeek: StartingDayOfWeek.monday,
    //               //     formatAnimation: FormatAnimation.slide,
    //               //     events: widget.events,
    //               //     headerStyle: HeaderStyle(
    //               //       centerHeaderTitle: true,
    //               //       formatButtonVisible: false,
    //               //       titleTextStyle:
    //               //       TextStyle(color: Colors.white, fontSize: 16),
    //               //       leftChevronIcon: Icon(
    //               //         Icons.arrow_back_ios,
    //               //         color: Colors.white,
    //               //         size: 15,
    //               //       ),
    //               //       rightChevronIcon: Icon(
    //               //         Icons.arrow_forward_ios,
    //               //         color: Colors.white,
    //               //         size: 15,
    //               //       ),
    //               //       leftChevronMargin: EdgeInsets.only(left: 70),
    //               //       rightChevronMargin: EdgeInsets.only(right: 70),
    //               //     ),
    //               //     calendarStyle: CalendarStyle(
    //               //         weekendStyle: TextStyle(color: Colors.white),
    //               //         weekdayStyle: TextStyle(color: Colors.white)),
    //               //     daysOfWeekStyle: DaysOfWeekStyle(
    //               //         weekendStyle: TextStyle(color: Colors.white),
    //               //         weekdayStyle: TextStyle(color: Colors.white)),
    //               //   ),
    //               // ),
    //             ]),
    //           ),
    //
    //         ),
    //
    //
    //
    //
    //       ];
    //     },
    //     body: TabBarView(
    //       controller: tabContoller,
    //       children: [
    //         // Container(
    //         //   height: 350,
    //         //   child: TableCalendar(
    //         //     availableCalendarFormats:{CalendarFormat.month : 'Month'} ,
    //         //     calendarController: _calendarController,
    //         //     //   initialCalendarFormat: CalendarFormat.week,
    //         //     startingDayOfWeek: StartingDayOfWeek.monday,
    //         //     formatAnimation: FormatAnimation.slide,
    //         //     events: widget.events,
    //         //     headerStyle: HeaderStyle(
    //         //       centerHeaderTitle: true,
    //         //       formatButtonVisible: false,
    //         //       titleTextStyle:
    //         //       TextStyle(color: Colors.white, fontSize: 16),
    //         //       leftChevronIcon: Icon(
    //         //         Icons.arrow_back_ios,
    //         //         color: Colors.white,
    //         //         size: 15,
    //         //       ),
    //         //       rightChevronIcon: Icon(
    //         //         Icons.arrow_forward_ios,
    //         //         color: Colors.white,
    //         //         size: 15,
    //         //       ),
    //         //       leftChevronMargin: EdgeInsets.only(left: 70),
    //         //       rightChevronMargin: EdgeInsets.only(right: 70),
    //         //     ),
    //         //     calendarStyle: CalendarStyle(
    //         //         weekendStyle: TextStyle(color: Colors.white),
    //         //         weekdayStyle: TextStyle(color: Colors.white)),
    //         //     daysOfWeekStyle: DaysOfWeekStyle(
    //         //         weekendStyle: TextStyle(color: Colors.white),
    //         //         weekdayStyle: TextStyle(color: Colors.white)),
    //         //   ),
    //         // ),
    //         // Container(
    //         //   height: 400,
    //         //   child: Expanded(
    //         //     child: Card(
    //         //       child: ListView.builder(
    //         //           reverse: true,
    //         //           itemCount: widget.eventList.length,
    //         //           itemBuilder: (BuildContext context, index) {
    //         //            // var item = widget.eventList[index];
    //         //             return Container(height: 200,
    //         //                 child:
    //         //               ListView.builder(itemCount: widget.eventList[index].length,itemBuilder: (c,i){
    //         //                 return ListTile(title: Text(widget.eventList[index][i].workoutTitle),);
    //         //               })
    //         //             );
    //         //           }),
    //         //     ),
    //         //   ),
    //         // ),
    //       ],
    //     )),
  }
}
