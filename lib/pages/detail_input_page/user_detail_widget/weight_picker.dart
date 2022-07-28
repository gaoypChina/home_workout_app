

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightPicker extends StatefulWidget {
  const WeightPicker({Key? key}) : super(key: key);

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  int unit = 0;
  int unitKgValue = 60;
  int unitLbsValue = 140;
  int decimalValue = 5;

  @override
  Widget build(BuildContext context) {
    _buildUnit({required String title, required int index}) {
      bool isSelected = index == unit;
      return InkWell(
        onTap: () {
          setState(() {
            unit = index;
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              border: Border.all(
                  color: Theme.of(context).primaryColor, width: 1.5)),
          child: Text(
            title,
            style: TextStyle(
                color:
                isSelected ? Colors.white : Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 18,
        ),
        Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Add Your Weight",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
        SizedBox(
          height: 16,
        ),
        Container(
          height: .8,
          color: Colors.grey.withOpacity(.2),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 8,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildUnit(title: " Kg ", index: 0),
                SizedBox(
                  height: 4,
                ),
                _buildUnit(title: "Lbs", index: 1),

              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(
                    width: 12,
                  ),

                  Spacer(),
                  NumberPicker(
                    itemHeight: 50,
                    value: unit == 0 ? unitKgValue : unitLbsValue,
                    step: 1,
                    minValue: 25,
                    maxValue: unit == 0 ? 300 : 650,
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(.2)),
                    selectedTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textMapper: (title) {
                      return "$title";
                    },
                    onChanged: (value) {
                      setState(() {
                        unit == 0 ? unitKgValue = value : unitLbsValue = value;
                      });
                    },
                  ),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      ",",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                  ),
                  NumberPicker(
                    infiniteLoop: true,
                    itemHeight: 50,
                    value: decimalValue,
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(.2)),
                    step: 1,
                    minValue: 0,
                    maxValue: 9,
                    selectedTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    textMapper: (title) {
                      return "$title ";
                    },
                    onChanged: (value) {
                      setState(() {
                        decimalValue = value;
                      });
                    },
                  ),
                  Text(
                    unit == 0 ? "  Kg " : "  Lbs",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Spacer(),
            TextButton(onPressed: () {
              Navigator.of(context).pop();

            }, child: Text("CANCEL")),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(onPressed: () {
              double res = 0.0;
              if(unit == 0){
                res = unitKgValue + decimalValue/10;
              }else{
                res = unitLbsValue + decimalValue/10;
              }
              Navigator.pop(context, res);
            }, child: Text("DONE")),
            SizedBox(
              width: 18,
            )
          ],
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }
}
