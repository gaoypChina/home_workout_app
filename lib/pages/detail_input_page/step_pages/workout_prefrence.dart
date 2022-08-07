import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_detail_provider.dart';
import '../../../widgets/active_goal_settings.dart';
import '../user_detail_widget/custom_detail_input.dart';
import '../user_detail_widget/user_detail_submit_button.dart';

class WorkoutPreference extends StatefulWidget {
  final Function onBack;
  final Function onNext;
  const WorkoutPreference(
      {Key? key, required this.onBack, required this.onNext})
      : super(key: key);

  @override
  State<WorkoutPreference> createState() => _WorkoutPreferenceState();
}

class _WorkoutPreferenceState extends State<WorkoutPreference> {
  List<DayIndex> trainingDayList = [
    DayIndex(index: 1, value: "1 Day"),
    DayIndex(index: 2, value: "2 Days"),
    DayIndex(index: 3, value: "3 Days"),
    DayIndex(index: 4, value: "4 Days"),
    DayIndex(index: 5, value: "5 Days"),
    DayIndex(index: 6, value: "6 Days"),
    DayIndex(index: 7, value: "7 Days"),
  ];

  List<DayIndex> firstDayList = [
    DayIndex(index: 1, value: "Saturday"),
    DayIndex(index: 2, value: "Sunday"),
    DayIndex(index: 3, value: "Monday")
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(context);
    return Scaffold(
      bottomNavigationBar: UserDetailSubmitButton(
        onTap: widget.onNext,
        isActive: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              "Set your weekly goal",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
                "We recommend training at least 3 days weekly for a better result"),
            SizedBox(
              height: 28,
            ),
            CustomDetailInput(
              hasData: provider.weeklyTrainingDay != null,
              onTap: () async {
                int? res = await showDialog(
                    context: context,
                    builder: (context) {
                      return DaySelector(
                        title: "Weekly training days",
                        initialValue: provider.weeklyTrainingDay ?? 3,
                        dayList: trainingDayList,
                      );
                    });
                provider.setWeeklyTrainingDays(res);
              },
              title: "Weekly training days",
              content: provider.weeklyTrainingDayString,
            ),
            SizedBox(
              height: 28,
            ),
            CustomDetailInput(
              hasData: provider.firstDayOfWeek != null,
              onTap: () async {
                int? res = await showDialog(
                    context: context,
                    builder: (context) {
                      return DaySelector(
                        title: "First Day of week",
                        initialValue: provider.firstDayOfWeek ?? 1,
                        dayList: firstDayList,
                      );
                    });

                provider.setFirstDayOfWeek(res);
              },
              title: "First day of week",
              content: provider.firstDayOfWeekString,
            ),
          ],
        ),
      ),
    );
  }
}
