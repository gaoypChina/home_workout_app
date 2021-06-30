import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/models/recent_workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../database/utils.dart';

class TableEventsExample extends StatefulWidget {
  final Map<DateTime, List> events;
  final List<List<RecentWorkout>> eventList;
  final Set<String> dateSet;

  TableEventsExample({this.events, this.eventList, this.dateSet});

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  void initState() {
    super.initState();
    print(widget.events);
    print("--------------------");
    print(widget.eventList);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(widget.events);
    print("--------------------");
    print(widget.eventList);
    List<String> dateList = widget.dateSet.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: ListView(
        children: [
          Container(
            child: TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              sixWeekMonthsEnforced: true,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              availableGestures: AvailableGestures.horizontalSwipe,

              eventLoader: (DateTime event) {
                if (widget
                        .events[DateTime(event.year, event.month, event.day)] ==
                    null)
                  return [];
                else
                  return widget
                      .events[DateTime(event.year, event.month, event.day)];
              },
              //      eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                canMarkersOverflow: true,
                isTodayHighlighted: false,


                markersOffset: PositionedOffset(top: 160, bottom: 190, end: 1),
                markerDecoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                markerSize: 40,
                markersMaxCount: 1,
              ),

              onDaySelected: (DateTime t1, DateTime t2) {
                print(t1.toString() +
                    " and " +
                    t2.toString() +
                    " my date " +
                    DateTime.parse(widget.eventList[0][0].date.toString())
                        .toString());
              },
              //    onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 700,
            child: Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: dateList.length,
                  itemBuilder: (BuildContext context, index) {
                    // var item = widget.eventList[index];
                    return Container(
                      height: 50 + widget.eventList[index].length * 70.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            dateList[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.eventList[index].length,
                                  itemBuilder: (c, i) {
                                    var item = widget.eventList[index][i];
                                    return ListTile(
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                            "assets/animated-cover/abs.png"),
                                      ),
                                      title: Text(item.workoutTitle),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Calories : ${item.calories}"),
                                          Text("Exercise : ${item.exercise}"),
                                          Text("Time : ${item.activeTime}")
                                        ],
                                      ),
                                    );
                                  })),
                          Divider(
                            height: 1,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
