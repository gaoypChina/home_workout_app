import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../main.dart';

class BMIPicker extends StatefulWidget {
  final double height;
  final double weight;

  BMIPicker({@required this.height, @required this.weight});
  @override
  _BMIPickerState createState() => _BMIPickerState();
}

class _BMIPickerState extends State<BMIPicker> {
  final constants = Constants();


  int weightIndex = 0;
  int heightIndex = 0;
  double height = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {


    String heightCm = widget.height == null ? 0.toString() : widget.height.toStringAsFixed(0);
    String weightKg = widget.weight == null ? 0.toString() : widget.weight.toStringAsFixed(0);

    TextEditingController _cmController = TextEditingController(text: heightCm);
    TextEditingController _feetController = TextEditingController();
    TextEditingController _inchController = TextEditingController();
    TextEditingController _kgController = TextEditingController(text: weightKg);
    TextEditingController _lbsController = TextEditingController();


    showToast(String msg) {
      return constants.getToast(msg);
    }

    onSubmit() {
      if (heightIndex == 0) {
        height = double.tryParse(_cmController.text);
        if (height == null || height <=50) {
          showToast("Please enter valid height value");
        }
      }

      if (heightIndex == 1) {
        double feet = double.tryParse(_feetController.text);
        double inch = double.tryParse(_inchController.text);
        if (feet == null || inch == null || feet <=2) {
          showToast("Please enter valid height value");
        } else {
          double inchHeight = (feet * 12) + inch;
          height = inchHeight * 2.54;
        }
      }

      if (weightIndex == 0) {
        weight = double.tryParse(_kgController.text);
        if (weight == null|| weight <=20 ) {
          showToast("Please enter valid weight value");
        }

      }

      if (weightIndex == 1) {
        double lbsWeight = double.tryParse(_lbsController.text);
        if (lbsWeight == null || lbsWeight <=50) {
          showToast("Please enter valid weight value");
        } else {
          weight = lbsWeight / 2.205;
          print(weight);
        }
      }
      if (height != null && weight != null && height >50 && weight >20){
        Navigator.pop(context, [height, weight]);
      }

    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                "Height",
                style: textTheme.bodyText1
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 16,
            ),
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
                  //   icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                  activeBgColors: [
                    [Colors.blue.shade700],
                    [Colors.blue.shade700]
                  ],
                  onToggle: (index) {
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
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                "Weight",
                style: textTheme.bodyText1
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 16,
            ),

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
                "Submit",
                style: textTheme.button.copyWith(color: Colors.blue.shade700),
              )),
        ],
      ),
    );
  }
}
