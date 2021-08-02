import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/notification_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class ReminderTab extends StatefulWidget {
  static const routeName = "reminder-screen";

  @override
  _ReminderTabState createState() => _ReminderTabState();
}



class _ReminderTabState extends State<ReminderTab> {
  FlutterLocalNotificationsPlugin fltrNotification;
  Constants constants = Constants();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  TimeOfDay reminderTime = TimeOfDay.now();
  bool isChecked = true;
  List<bool> activeDayList = [];
  bool isLoading = true;

  List<ReminderDay> selector = [
    ReminderDay(day: "Monday", activate: true, dayValue: 1),
    ReminderDay(day: "Tuesday", activate: true, dayValue: 2),
    ReminderDay(day: "Wednesday", activate: true, dayValue: 3),
    ReminderDay(day: "Thursday", activate: true, dayValue: 4),
    ReminderDay(day: "Friday", activate: true, dayValue: 5),
    ReminderDay(day: "Saturday", activate: true, dayValue: 6),
    ReminderDay(day: "Sunday", activate: true, dayValue: 7),
  ];

  _loadReminderTime() async {
    int hour = await spHelper.loadInt(spKey.hourTime);
    int minute = await spHelper.loadInt(spKey.minuteTime);
    if (hour != null && minute != null) {
      return reminderTime = TimeOfDay(hour: hour, minute: minute);
    }
    reminderTime = TimeOfDay(hour: 8, minute: 0);
  }

  _loadIsActiveDay() async {
    for (int i = 0; i < selector.length; i++) {
      bool active;
      await spHelper
          .loadIsActive(selector[i].day)
          .then((value) => active = value);
      selector[i].activate = active;
      activeDayList.insert(i, active);
    }
  }

  _loadInit() async {
    setState(() {
      isLoading = true;
    });
    await _loadReminderTime();
    await _loadIsActiveDay();
    setState(() {
      isLoading = false;
    });
  }
  _setReminder() {
    List<int> dayList = [];
    selector.forEach((element) {
      if (element.activate == true) {
        dayList.add(element.dayValue);
      }
    });

    NotificationHelper.showScheduledNotification(
        payload: "",
        days: dayList,
        title: "Home Workout Reminder",
        id: 1,
        body: "Click! Start your workout now",
        time: Time(reminderTime.hour, reminderTime.minute)
    );
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

 String getTimeString(int hour, int minute){
  String  getParsedTime(int time){
      if(time.toString().length <=1)
        return "0$time";
      return time.toString();
    }

   String getAbsolute(int time) {
    if(time == 0)
      return getParsedTime(12);
      if (time > 12)
        return getParsedTime(time - 12);
      return getParsedTime(time);
    }

    getPrefix(int time){
      if(time >=12)
        return " PM";
      return " AM";
    }

    return getAbsolute(hour) + " : " + getParsedTime(minute) + getPrefix(hour);


  }

  _pickTime() async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: reminderTime);
    if (t != null) {
      print(t.minute);
      print(t.hour);
      spHelper.saveInt(spKey.hourTime, t.hour);
      spHelper.saveInt(spKey.minuteTime, t.minute);
      setState(() {
        reminderTime = t;
      });
    }
    return;
  }



  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    var titleStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 17,);
    var timeStyle = TextStyle(
        fontWeight: FontWeight.w400, fontSize: 14,);

   Color tileColor = isDark?Colors.black:Colors.white;

    getDivider(){
      return  Container(
          margin: EdgeInsets.only(left: 14,right: 8),
          height: 1,
          color: Colors.grey.shade300,);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Workout Reminder",style: TextStyle(color: isDark?Colors.white:Colors.black),
        ),
      ),
     backgroundColor:isDark?Colors.black: Colors.white,
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
              style: constants.textStyle.copyWith(fontSize: 14,fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: SwitchListTile(
                     tileColor: tileColor,
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
                    getDivider(),
                    Material(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ListTile(
                        tileColor: tileColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        title: Text(
                          "Workout Time",
                          style: titleStyle,
                        ),
                        trailing: Icon(Icons.edit),
                        subtitle: Text(getTimeString(reminderTime.hour, reminderTime.minute),style: timeStyle,),
                        onTap: () async {
                          await _pickTime();
                          _setReminder();
                        },
                      ),
                    ),
                    getDivider(),
                    Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: ListTile(
                          tileColor: tileColor,
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
                            List<ReminderDay> list = await showDialog(
                                context: context,
                                builder: (context) => DaySelector(selector));
                            setState(() {});
                            if (list != null) {
                              list.forEach((element) {
                                spHelper.saveBool(
                                    element.day, element.activate);
                                //  NotificationHelper.showScheduledNotification();
                              });
                              _setReminder();
                            }
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
        ),
      ),
    );
  }
}

class DaySelector extends StatefulWidget {
  final List<ReminderDay> selector;

  DaySelector(this.selector);

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  SpHelper spHelper = SpHelper();
  List<ReminderDay> selectedDayList = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              "Select Repeat Day",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.selector.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(widget.selector[index].day),
                    contentPadding: EdgeInsets.symmetric(horizontal: 28),
                    activeColor: Colors.blue,
                    value: widget.selector[index].activate,
                    onChanged: (value) {
                      setState(() {
                        widget.selector[index].activate = value;
                      });
                    },
                  );
                }),
          ),
          Row(
            children: [
              Spacer(
                flex: 6,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              SizedBox(
                width: 18,
              ),
              TextButton(
                  onPressed: () {
                    widget.selector.forEach((element) {
                      if (element.activate == true) {
                        selectedDayList.add(element);
                      }
                    });
                    Navigator.pop(context, selectedDayList);
                  },
                  child: Text("Save")),
              Spacer(
                flex: 1,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ReminderDay {
  @required
  String day;
  @required
  bool activate;
  @required
  int dayValue;

  ReminderDay({this.day, this.activate, this.dayValue});
}