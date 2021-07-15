import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../report_page.dart';

class WeeklyWorkoutReport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<ActiveDay> dateList = [];
    for (int i = 0; i < 7; i++) {
      dateList.add(ActiveDay(
          date: DateTime.now().subtract(Duration(days: i)),
          isActive: DateTime.now().subtract(Duration(days: i)).day % 4 == 0
              ? false
              : true));
    }
    dateList = dateList.reversed.toList();

    getWeeklyUpdate() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dateList
            .map((activeDay) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Text(DateFormat('EEEE').format(activeDay.date)[0],style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: activeDay.isActive
                          ? Colors.blue.shade700.withOpacity(.6)
                          : Colors.white,
                    ),
                  ),
                  radius: 15),
              SizedBox(height: 5,),
              Text(activeDay.date.day.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
            ],
          ),
        ))
            .toList(),
      );
    }
    return Container(
      child: getWeeklyUpdate(),
    );
  }
}




// Container(
//   padding: EdgeInsets.only(left: 10, right: 16),
//   child: InkWell(
//     onTap: () {},
//     child: AbsorbPointer(
//       child: TableCalendar(
//         firstDay: DateTime(2000, 08, 12),
//         lastDay: DateTime.now(),
//         focusedDay: DateTime.now(),
//         calendarFormat: CalendarFormat.week,
//         eventLoader: (DateTime event) {
//           if (events[DateTime(event.year, event.month, event.day)] ==
//               null)
//             return [];
//           else
//             return events[
//                 DateTime(event.year, event.month, event.day)];
//         },
//         daysOfWeekVisible: true,
//         headerVisible: false,
//         shouldFillViewport: false,
//         rowHeight: 40,
//         startingDayOfWeek: StartingDayOfWeek.sunday,
//         calendarStyle: CalendarStyle(
//           markersOffset: PositionedOffset(top: 12),
//           markerDecoration: BoxDecoration(color: Colors.amber),
//           markerSize: 22,
//           markersMaxCount: 1,
//         ),
//       ),
//     ),
//   ),
// ),