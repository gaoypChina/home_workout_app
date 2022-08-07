import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../constants/constant.dart';
import '../../../helper/notification_helper.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';

class ReminderTab extends StatefulWidget {
  static const routeName = "reminder-screen";

  @override
  _ReminderTabState createState() => _ReminderTabState();
}

class _ReminderTabState extends State<ReminderTab> {
  late FlutterLocalNotificationsPlugin fltrNotification;
  Constants constants = Constants();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  TimeOfDay reminderTime = TimeOfDay.now();
  bool isChecked = true;
  List<bool> activeDayList = [];
  bool isLoading = true;
  bool showSaveButton = false;

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
    int? hour = await spHelper.loadInt(spKey.hourTime);
    int? minute = await spHelper.loadInt(spKey.minuteTime);
    if (hour != null && minute != null) {
      return reminderTime = TimeOfDay(hour: hour, minute: minute);
    }
    reminderTime = TimeOfDay(hour: 8, minute: 0);
  }

  _loadIsActiveDay() async {
    for (int i = 0; i < selector.length; i++) {
      bool active;
      active = await spHelper.loadIsActive(selector[i].day) ?? false;
      selector[i].activate = active;
      activeDayList.insert(i, active);
    }
  }

  _loadReminderToggle() async {
    isChecked = await spHelper.loadBool(spKey.reminderToggle) ?? false;
  }

  _loadInit() async {
    setState(() {
      isLoading = true;
    });
    await _loadReminderTime();
    await _loadIsActiveDay();
    await _loadReminderToggle();
    setState(() {
      isLoading = false;
    });
  }

  _setReminder(bool isOn) {
    List<int> dayList = [];
    if (isOn) {
      selector.forEach((element) {
        if (element.activate == true) {
          dayList.add(element.dayValue);
        }
      });
    } else {
      dayList.add(7);
    }
    print(dayList);
    NotificationHelper.showScheduledNotification(
        payload: "",
        days: dayList,
        title: "Home Workout Reminder",
        id: 1,
        body:
            "Complete your daily workout task and move a step closer to your goal",
        time: Time(reminderTime.hour, reminderTime.minute));
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  String getTimeString(int hour, int minute) {
    String getParsedTime(int time) {
      if (time.toString().length <= 1) return "0$time";
      return time.toString();
    }

    String getAbsolute(int time) {
      if (time == 0) return getParsedTime(12);
      if (time > 12) return getParsedTime(time - 12);
      return getParsedTime(time);
    }

    getPrefix(int time) {
      if (time >= 12) return " PM";
      return " AM";
    }

    return getAbsolute(hour) + " : " + getParsedTime(minute) + getPrefix(hour);
  }

  _pickTime() async {
    Navigator.of(context).push(showPicker(
      context: context,
      iosStylePicker: true,
      value: reminderTime,
      onChange: (TimeOfDay t) {
        spHelper.saveInt(spKey.hourTime, t.hour);
        spHelper.saveInt(spKey.minuteTime, t.minute);
        setState(() {
          reminderTime = t;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
    );
    var timeStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    );

    getDivider() {
      return Container(
        height: .8,
        color: Colors.grey.withOpacity(.1),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          showSaveButton
              ? Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      _setReminder(isChecked);
                      constants.getToast("Your changes saved successfully");
                      Navigator.of(context).pop();
                    },
                    child: Text("Save"),
                  ),
                )
              : Container(),
        ],
        title: Text(
          "Workout Reminder",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            getDivider(),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
              child: Text(
                "Set a workout reminder to help you meet your goals faster. you can change the frequency or turn off in your account settings at any time.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.8),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            getDivider(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.only(left: 12, right: 4),
                    activeColor: Colors.blue,
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
                        showSaveButton = true;
                      });
                      spHelper.saveBool(spKey.reminderToggle, value);
                    },
                  ),
                  getDivider(),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    title: Text(
                      "Workout Time",
                      style: titleStyle,
                    ),
                    trailing: Icon(Icons.edit),
                    subtitle: Text(
                      getTimeString(reminderTime.hour, reminderTime.minute),
                      style: timeStyle,
                    ),
                    onTap: () async {
                      await _pickTime();
                      setState(() {
                        showSaveButton = true;
                      });
                    },
                  ),
                  getDivider(),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    title: Text(
                      "Workout Day",
                      style: titleStyle,
                    ),
                    trailing: Icon(
                      Icons.edit,
                    ),
                    onTap: () async {
                      List<ReminderDay>? list = await showDialog(
                          context: context,
                          builder: (context) => DaySelector(selector));
                      setState(() {
                        showSaveButton = true;
                      });
                      if (list != null) {
                        list.forEach((element) {
                          spHelper.saveBool(element.day, element.activate);
                          //  NotificationHelper.showScheduledNotification();
                        });
                      }
                    },
                    subtitle: Container(
                      padding: EdgeInsets.only(top: 5),
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
                  ),
                  getDivider(),
                ],
              ),
            ),
          ],
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
      insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 24),
              child: Row(
                children: [
                  Text(
                    "Select Repeat Day",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.close_outlined)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(.2),
            ),
            SizedBox(
              height: 2,
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
                      activeColor: Theme.of(context).primaryColor,
                      value: widget.selector[index].activate,
                      onChanged: (value) {
                        setState(() {
                          widget.selector[index].activate = value!;
                        });
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(.2),
            ),
            SizedBox(
              height: 2,
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
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: TextStyle(color: Colors.grey),
                    )),
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
                    child: Text("Save".toUpperCase())),
                Spacer(
                  flex: 1,
                )
              ],
            ),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class ReminderDay {
  String day;
  bool activate;
  int dayValue;

  ReminderDay(
      {required this.day, required this.activate, required this.dayValue});
}
