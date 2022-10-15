import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RangeDatePicker extends StatefulWidget {
  const RangeDatePicker({Key? key}) : super(key: key);

  @override
  State<RangeDatePicker> createState() => _RangeDatePickerState();
}

class _RangeDatePickerState extends State<RangeDatePicker> {
  DateTime? firstDate;
  DateTime? lastDate;
  String error = "";

  getFormatedDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    buildPicker({required String title, DateTime? selectedDate}) {
      return Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022, 08, 12),
                  lastDate: DateTime.now());

              if (date == null) {
                return;
              } else {
                if (title.toLowerCase().contains("first")) {
                  log(date.toString());
                  firstDate = date;
                } else {
                  lastDate = date;
                }
                setState(() {});
              }
            },
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 18, right: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  selectedDate == null
                      ? Text("$title")
                      : Text(getFormatedDate(selectedDate),style: TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )
        ],
      );
    }

    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 28),
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Select Date",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: .5,
              color: Colors.grey.withOpacity(.5),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
               if(error !="")     Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.start,

                 children: [
                   Icon(Icons.error_outline,color: Colors.red,),
                   SizedBox(width: 8,),

                   Flexible(
                     child: Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          ),
                   ),
                 ],
               ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        buildPicker(
                            title: "First Date", selectedDate: firstDate),
                        Spacer(),
                        buildPicker(title: "Last Date", selectedDate: lastDate),
                      ],
                    ),
                    SizedBox(
                      height: 34,
                    ),

                    Row(
                      children: [
                        Spacer(),
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("Cancel")),
                        SizedBox(
                          width: 18,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (firstDate == null) {
                                error = "Please select first date";
                              } else if (lastDate == null) {
                                error = "Please select last date";
                              } else if (firstDate!.isAfter(lastDate!)) {
                                error = "Last date should be after first date";
                              } else {
                                Navigator.pop(
                                    context,
                                    DateTimeRange(
                                        start: firstDate!, end: lastDate!));
                              }
                              setState(() {});
                            },
                            child: Text("Apply"))
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ))
          ],
        )));
  }
}
