import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
class HeightWeightSelector extends StatefulWidget {
  final String label1;
  final String label2;
  final String title;
  final int selected;
  final String controller1;
  final String derivedController1;
  final String controller2;
  final String controller3;

  HeightWeightSelector({
    this.label1,
    this.label2,
    this.title,
    this.selected,
    this.controller1,
    this.controller2,
    this.controller3,
    this.derivedController1,
  });

  @override
  _HeightWeightSelectorState createState() => _HeightWeightSelectorState();
}

class _HeightWeightSelectorState extends State<HeightWeightSelector> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  int unitType = 0;
  double enteredValue;
  double toSaveData = 0;

  String previousEnteredValue(int unit) {
    if (unit == 0) {
      return widget.controller1;
    } else if (unit == 1) {
      return widget.derivedController1;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    unitType = (widget.selected == null) ? 0 : widget.selected;
    _controller1 = TextEditingController(text: previousEnteredValue(unitType));
    _controller2 = TextEditingController(
        text: (unitType == null) ? "" : widget.controller2);
    _controller3 = TextEditingController(
        text: (unitType == null) ? "" : widget.controller3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(

        title: Text(widget.title),
        content: Container(
height: 100,
          child: Column(
            children: [
              ToggleSwitch(
                totalSwitches: 2,
                initialLabelIndex: unitType,
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                labels: [widget.label1, widget.label2],

                activeBgColors: [[Colors.blue.shade700], [Colors.blue.shade700]],
                onToggle: (index) {
                  setState(() {
                    unitType = index;
                    _controller1.clear();
                    _controller2.clear();
                    _controller3.clear();
                  });
                  print('switched to: $index');
                },
              ),
              SizedBox(
                height: 10,
              ),
              (unitType == 1 && widget.label2 == "feet")
                  ? Container(
                //   height: 50,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                          suffix: Text("feet"),
                          labelText: "feet",
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              new BorderSide(color: Colors.teal)),
                        ),
                        controller: _controller2,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            enteredValue = value as double;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                          suffix: Text("inch"),
                          labelText: "inch",
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              new BorderSide(color: Colors.teal)),
                        ),
                        controller: _controller3,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            enteredValue = value as double;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
                  : Container(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    suffix: Text(
                        (unitType == 0) ? widget.label1 : widget.label2),
                    labelText:
                    (unitType == 0) ? widget.label1 : widget.label2,
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        new BorderSide(color: Colors.blueGrey)),
                  ),
                  controller: _controller1,
                  keyboardType:
                  TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      enteredValue = value as double;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel",style: TextStyle(color: Colors.grey),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Save"),
            onPressed: () async {
              double value = await _calc();
              Navigator.of(context).pop(value);
            },
          )
        ],
      ),
    );
  }

  _calc() {
    if (unitType == 1 && widget.label2 == "feet") {
      if (double.parse(_controller2.text) != 0.0)
        toSaveData = (double.parse(_controller2.text) * 12 +
            double.parse(_controller3.text)) *
            2.54;
    } else if (double.parse(_controller1.text) != 0.0) {
      if (widget.label1 == "cm" && unitType == 0) {
        print(_controller1);
        toSaveData = double.parse(_controller1.text);
      } else if (widget.label1 == "kg" && unitType == 0) {
        toSaveData = double.parse(_controller1.text);
      } else if (widget.label2 == "lbs" && unitType == 1) {
        toSaveData = double.parse(_controller1.text) * 0.453592;
      }
    } else {
      Navigator.of(context).pop();
      toSaveData = 90;
    }
    return toSaveData;
  }
}
