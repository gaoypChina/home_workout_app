import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WorkoutTimePicker extends StatefulWidget {
  final int value;
  final int minimumVal;
  final int maximumVal;

  WorkoutTimePicker(
      {required this.value,
      required this.maximumVal,
      required this.minimumVal});

  @override
  _WorkoutTimePickerState createState() => _WorkoutTimePickerState();
}

class _WorkoutTimePickerState extends State<WorkoutTimePicker> {
  int selectedValue = 30;

  @override
  void initState() {
    selectedValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return AlertDialog(
      title: Text("Set Duration (${widget.minimumVal} ~ ${widget.maximumVal} Sec)"),
      content: NumberPicker(
        value: selectedValue,
        step:widget.maximumVal ==15?1: 5,
        minValue: widget.minimumVal,
        maxValue: widget.maximumVal,
        selectedTextStyle: TextStyle(color:isDark? Colors.blue:Colors.blue.shade700, fontSize: 18,fontWeight: FontWeight.w500),
        textMapper: (title) {
          return "$title Sec";
        },
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
            onPressed: () => Navigator.pop(context, selectedValue),
            child: Text("Save")),
      ],
    );
  }
}
