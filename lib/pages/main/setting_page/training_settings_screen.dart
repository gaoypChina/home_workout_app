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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 12, bottom: 12),
          child: Row(
            children: [
              Text(
                "Set Duration(${widget.minimumVal} ~ ${widget.maximumVal} Sec)",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 1),
              ),
              Spacer(),

              InkWell(
                onTap: ()=>Navigator.of(context).pop(),
                child: Container(padding: EdgeInsets.all(8),
                child: Icon(Icons.close),),
              ),
              SizedBox(width: 8,)
            ],
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(.2),
          height: 1,
        ),
        SizedBox(height: 12,),

        Center(
          child: NumberPicker(
            haptics: true,
            itemHeight: 50,
            value: selectedValue,
            step: widget.maximumVal == 15 ? 1 : 5,
            minValue: widget.minimumVal,
            maxValue: widget.maximumVal,

            decoration: BoxDecoration(color: Colors.blue.withOpacity(.2)),
            selectedTextStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            itemCount: 3,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
            textMapper: (title) {
              return "$title Sec";
            },
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ),
        SizedBox(height: 12,),
        Container(
          padding: EdgeInsets.only(right: 12),
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(80, 42)),
            child: Text("Save"),onPressed: () => Navigator.pop(context, selectedValue),),
        ),
        SizedBox(height: 18,)
      ],
    );
  }
}


