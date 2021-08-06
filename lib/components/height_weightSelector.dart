import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../main.dart';

class HeightSelector extends StatefulWidget {
  final double height;
  final int unitValue;

  HeightSelector({@required this.height, @required this.unitValue});

  @override
  _HeightSelectorState createState() => _HeightSelectorState();
}

class _HeightSelectorState extends State<HeightSelector> {
  int heightIndex = 0;
  double height = 0;
  final constants = Constants();
  TextEditingController _cmController = TextEditingController();
  TextEditingController _feetController = TextEditingController();
  TextEditingController _inchController = TextEditingController();

  onSubmit() {
    if (heightIndex == 0) {
      height = double.tryParse(_cmController.text);
      if (height == null || height <= 50) {
        constants.getToast("Please enter valid height value");
      }
    }

    if (heightIndex == 1) {
      double feet = double.tryParse(_feetController.text);
      double inch = double.tryParse(_inchController.text);
      if (feet == null || inch == null || feet <= 2) {
        constants.getToast("Please enter valid height value");
      } else {
        double inchHeight = (feet * 12) + inch;
        height = inchHeight * 2.54;
      }
    }


    if(height >50)
      Navigator.pop(context, height);
  }

  @override
  void initState() {
    setController();
    super.initState();
  }

  setController() {
    heightIndex = widget.unitValue ?? 0;
    String cmHeight = "0";
    String feetHeight = "0";
    String inchHeight = "0";

    if (widget.height == null) {
    } else {
      cmHeight = widget.height.toStringAsFixed(0);

      int feetVal = widget.height ~/ 30.48;
      feetHeight = feetVal.toString();

      double inchVal = (widget.height - (feetVal * 30.48)) * 0.393701;
      if (inchVal == 12) {
        inchHeight = 0.toStringAsFixed(0);
        feetHeight = (int.parse(feetHeight) + 1).toString();
      } else {
        inchHeight = inchVal.toStringAsFixed(0);
      }
    }

    _cmController = TextEditingController(text: cmHeight);
    _feetController = TextEditingController(text: feetHeight);
    _inchController = TextEditingController(text: inchHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 16),
        title: Text(
          "Height",
          style: textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ToggleSwitch(
                  initialLabelIndex: heightIndex,
                  minWidth: 100,
                  cornerRadius: 10.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['CM', 'Feet'],
                  activeBgColors: [
                    [Colors.blue.shade700],
                    [Colors.blue.shade700]
                  ],
                  onToggle: (index) {
                    print(index);
                    setState(() {
                      heightIndex = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            heightIndex == 1
                ? Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              suffix: Text("Feet"),
                              labelText: "Feet",
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                            ),
                            controller: _feetController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 100,
                          child: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              suffix: Text("Inch"),
                              labelText: "Inch",
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                            ),
                            controller: _inchController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 200,
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        suffix: Text("Cm"),
                        labelText: "Height",
                        border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: new BorderSide(color: Colors.blueGrey)),
                      ),
                      controller: _cmController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: textTheme.button.copyWith(color: Colors.grey),
              )),
          TextButton(
              onPressed: () => onSubmit(),
              child: Text(
                "Save",
                style: textTheme.button.copyWith(color: Colors.blue.shade700),
              )),
        ],
      ),
    );
  }
}

/// weight selector

class WeightSelector extends StatefulWidget {
  final int weightIndex;

  final double weight;

  WeightSelector({@required this.weight, @required this.weightIndex});

  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  int weightIndex =0;
  double weight =0;
  Constants constants = Constants();
  TextEditingController _kgController = TextEditingController();
  TextEditingController _lbsController = TextEditingController();

  onSubmit(){
    if (weightIndex == 0) {
      weight = double.tryParse(_kgController.text);
      if (weight == null|| weight <=20 ) {
        constants.getToast("Please enter valid weight value");
      }

    }

    if (weightIndex == 1) {
      double lbsWeight = double.tryParse(_lbsController.text);
      if (lbsWeight == null || lbsWeight <=50) {
        constants.getToast("Please enter valid weight value");
      } else {
        weight = lbsWeight / 2.205;
        print(weight);
      }
    }
    if ( weight != null && weight >20){
      Navigator.pop(context, weight);
    }
  }

  @override
  void initState() {
    _kgController = TextEditingController(text: widget.weight.toStringAsFixed(0));
    _lbsController = TextEditingController(text: (widget.weight* 2.205).toStringAsFixed(0));
    weightIndex = widget.weightIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 16),

        title:  Text(
          "Weight",
          style: textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ToggleSwitch(
                  minWidth: 100,
                  initialLabelIndex: weightIndex,
                  cornerRadius: 10.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['KG', 'LBS'],
                  activeBgColors: [
                    [Colors.blue.shade700],
                    [Colors.blue.shade700]
                  ],
                  onToggle: (index) {
                    print(index);
                    setState(() {
                      weightIndex = index;
                    });
                  },
                ),
              ),
            ),


            SizedBox(
              height: 10,
            ),
            weightIndex == 0
                ? Container(
              width: 200,
              child: TextField(
                autofocus: true,

                decoration: InputDecoration(
                  suffix: Text("KG"),
                  labelText: "Kg",
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(color: Colors.blueGrey)),
                ),
                controller: _kgController,
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
              ),
            )
                : Container(
              width: 200,
              child: TextField(
                autofocus: true,

                decoration: InputDecoration(
                  suffix: Text("Lbs"),
                  labelText: "Lbs",
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(color: Colors.blueGrey)),
                ),
                controller: _lbsController,
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
              ),
            ),

          ],
        ),

        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: textTheme.button.copyWith(color: Colors.grey),
              )),
          TextButton(
              onPressed: () => onSubmit(),
              child: Text(
                "Save",
                style: textTheme.button.copyWith(color: Colors.blue.shade700),
              )),
        ],

      ),
    );
  }
}
