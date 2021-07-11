import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';

class ReminderTab extends StatefulWidget {
  static const routeName = "reminder-screen";

  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class ActiveDaySelector {
  String day;
  bool activate;

  ActiveDaySelector({this.day, this.activate = true});
}

class _ReminderTabState extends State<ReminderTab> {
  FlutterLocalNotificationsPlugin fltrNotification;
  Constants constants = Constants();
  SpHelper spHelper = SpHelper();
  TimeOfDay time;
  var notificationTime = DateTime.now();
  bool isChecked = true;

  List<ActiveDaySelector> selector = [
    ActiveDaySelector(day: "Monday", activate: true),
    ActiveDaySelector(day: "Tuesday", activate: true),
    ActiveDaySelector(day: "Wednesday", activate: true),
    ActiveDaySelector(day: "Thursday", activate: true),
    ActiveDaySelector(day: "Friday", activate: true),
    ActiveDaySelector(day: "Saturday", activate: true),
    ActiveDaySelector(day: "Sunday", activate: true),
  ];

  @override
  void initState() {
    time = TimeOfDay.now();
    _loadSaveData();
    _loadIsActiveDay();
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  _loadSaveData() async {
    String rt;
    await spHelper.loadReminderTime("reminderTime").then((value) => rt = value);
    setState(() {
      notificationTime = DateTime.parse(rt);
    });
  }

  List<bool> activeDayList = [];

  _loadIsActiveDay() async {
    for (int i = 0; i < selector.length; i++) {
      bool active;
      await spHelper
          .loadIsActive(selector[i].day)
          .then((value) => active = value);
      selector[i].activate = active;
      activeDayList.insert(i, active);
      print(
          "-=-=-=-----------------------------------------------------------------$active");
    }
    setState(() {});
  }

  Future _showNotification(TimeOfDay time) async {
    var androidDetails = new AndroidNotificationDetails(
        "id", "name", "description",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotification =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    var now = new DateTime.now();
    setState(() {
      notificationTime =
          new DateTime(now.year, now.month, now.day, time.hour, time.minute);
      spHelper.saveString("reminderTime", notificationTime.toIso8601String());
    });
    await fltrNotification.schedule(
        0, "task", "task added", notificationTime, generalNotification);
  }

  @override
  Widget build(BuildContext context) {
    _pickTime() async {
      TimeOfDay t =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (t != null) {
        setState(() {
          time = t;
        });
      }
    }

    var titleStyle = TextStyle(
        fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black);
    var timeStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey.shade800);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reminder",
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "Set a workout reminder to help you meet your goals faster. you can change the frequency or turn off in your account settings at any time.",
              style: constants.textStyle.copyWith(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: SwitchListTile(
                        tileColor: constants.tileColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        title: Text(
                          "Show Notification",
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          isChecked ? "Reminder is on" : "Reminder is off",
                          style: timeStyle,
                        ),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ListTile(
                        tileColor: constants.tileColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        title: Text(
                          "Workout Time",
                          style: titleStyle,
                        ),
                        trailing: Icon(Icons.edit),
                        subtitle: (notificationTime.hour <= 12)
                            ? Text(
                                '0${notificationTime.hour}'.substring(1) +
                                    ' : ${notificationTime.minute}  AM',
                                style: timeStyle,
                              )
                            : Text(
                                '0${notificationTime.hour}'.substring(1) +
                                    ' : ${notificationTime.minute}  PM',
                                style: timeStyle,
                              ),
                        onTap: () async {
                          await _pickTime();
                          if (isChecked) if (selector[
                                  DateTime.now().weekday - 1]
                              .activate) await _showNotification(time);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: ListTile(
                          tileColor: constants.tileColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          title: Text(
                            "Workout Day",
                            style: titleStyle,
                          ),
                          trailing: Icon(
                            Icons.edit,
                          ),
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) => DaySelector(selector));
                            setState(() {});
                          },
                          subtitle: Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selector.length,
                                itemBuilder: (context, index) {
                                  return (selector[index].activate == true)
                                      ? Text(
                                          '${selector[index].day.substring(0, 3)}    ',
                                          style: timeStyle,
                                        )
                                      : Text('');
                                }),
                          ),
                        )),
                  ],
            ),
          ),
        ],
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     Padding(
      //       padding: padding,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Text(
      //             "Show Notification",
      //             style: titleStyle,
      //           ),
      //           Switch(
      //             value: isChecked,
      //             onChanged: (value) {
      //               setState(() {
      //                 isChecked = value;
      //               });
      //             },
      //           )
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 1,
      //       color: Colors.white,
      //     ),
      //     Padding(
      //       padding: padding,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Text(
      //             "Workout Time",
      //             style: titleStyle,
      //           ),
      //           if (notificationTime.hour <= 12)
      //             Text(
      //               '0${notificationTime.hour}'.substring(1) +
      //                   ' : ${notificationTime.minute}  AM',
      //               style: timeStyle,
      //             ),
      //           if (notificationTime.hour > 12)
      //             Text(
      //               '0${notificationTime.hour}'.substring(1) +
      //                   ' : ${notificationTime.minute}  PM',
      //               style: timeStyle,
      //             ),
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 1,
      //       color: Colors.blue,
      //     ),
      //     GestureDetector(
      //         child: Padding(
      //           padding: EdgeInsets.all(12),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Workout Day",
      //                 style: titleStyle,
      //               ),
      //               Container(
      //                 height: 30,
      //                 width: 130,
      //                 child: ListView.builder(
      //                     scrollDirection: Axis.horizontal,
      //                     itemCount: selector.length,
      //                     itemBuilder: (context, index) {
      //                       return (selector[index].activate ==
      //                               true)
      //                           ? Text(
      //                               '${selector[index].day[0]}  ',
      //                               style: TextStyle(
      //                                   color: Colors.amberAccent),
      //                             )
      //                           : Text('');
      //                     }),
      //               ),
      //             ],
      //           ),
      //         ),
      //         onTap: () async {
      //           await showDialog(
      //               context: context,
      //               builder: (context) => DaySelector(selector));
      //           setState(() {});
      //         })
      //   ],
      // )
        ),
      ),
    );
  }

  Future notificationSelected(String payload) {
    // showDialog(
    //     context: context,
    //     builder: (_) => AlertDialog(
    //           title: Text("ALERT"),
    //           content: Text("CONTENT: $payload"),
    //         ));
  }
}

class DaySelector extends StatefulWidget {
  final List<ActiveDaySelector> selector;

  DaySelector(this.selector);

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  SpHelper spHelper = SpHelper();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(12.0, 20.0, 24.0, 12.0),
      title: Text("Select Day"),
      actions: [
        TextButton(
          child: Text("Save"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: Container(
        height: height * .50,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemExtent: 60,
            itemCount: widget.selector.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 16,),
                  Text(
                    widget.selector[index].day,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  Switch(
                    activeColor: Colors.blue,
                    value: widget.selector[index].activate,
                    onChanged: (value) {
                      setState(() {
                        widget.selector[index].activate = value;
                        spHelper.saveBool(widget.selector[index].day, value);
                      });
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
