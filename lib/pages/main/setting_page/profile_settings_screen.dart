import 'package:flutter/material.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/widgets/height_weightSelector.dart';
import 'package:intl/intl.dart';
import '../../../helper/sp_helper.dart';


class ProfileSettingScreen extends StatefulWidget {
  static const routeName = "profile-settings-screen";

  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  String name;
  String date;
  int gender;
  int unit;
  double heightValue;
  double weightValue;
  DateTime actualDate;

  //derived values

  double lbsWeight;
  double feetHeight;
  double inchHeight;

  getSavedData() async {
    await spHelper.loadString(spKey.date).then((value) {
      actualDate = DateTime.parse(value);
      String formatedDay = DateFormat.yMMMd().format(DateTime.parse(value));
      setState(() {
        date = formatedDay;
      });
    });

    await spHelper.loadString(spKey.name).then((value) {
      setState(() {
        name = value;
      });
    });

    await spHelper.loadInt(spKey.gender).then((value) {
      setState(() {
        gender = value;
      });
    });

    await spHelper.loadInt(spKey.unit).then((value) {
      setState(() {
        unit = value;
      });
    });

    await spHelper.loadDouble(spKey.height).then((value) {
      double feet = (value / 2.54) / 12;
      double inch = (feet - feet.toInt()) * 12;
      setState(() {
        feetHeight = feet;
        inchHeight = inch;
        heightValue = value;
      });
    });

    await spHelper.loadDouble(spKey.weight).then((value) {
      setState(() {
        weightValue = value;
        lbsWeight = value * 2.20462;
      });
    });
  }

  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();

  // BmiReport bmiReport = BmiReport();
  WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();

  @override
  void initState() {
    getSavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: (actualDate == null) ? DateTime.now() : actualDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked.toString() != date) {
        String formatedDay = DateFormat.yMMMd().format(picked);
        await spHelper.saveString(spKey.date, picked.toIso8601String());
        setState(() {
          date = formatedDay;
        });
      }
    }

    var textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w800);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        elevation: 0,
        leading: FlatButton(
          child: Icon(
            Icons.keyboard_backspace_sharp,
            color: Colors.white,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Expanded(
                //  height: 440,
                child: Card(
                  color: Colors.purple.withOpacity(.5),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("Name"),
                        trailing: (name != null)
                            ? Text(
                                name,
                                style: textStyle,
                              )
                            : Text(
                                "...........",
                                style: textStyle,
                              ),
                        onTap: () async {
                          String previousValue = name;
                          String a = await showDialog(
                              context: context,
                              builder: (context) => NameSelector(
                                    name: name,
                                  ));
                          String toSave = (a == null) ? previousValue : a;
                          await spHelper.saveString(spKey.name, toSave);
                          setState(() {
                            name = toSave;
                          });
                        },
                      ),
                      Divider(
                        thickness: 0,
                      ),
                      ListTile(
                          leading: Text("Birthday"),
                          trailing: (date == null)
                              ? Text(
                                  "....",
                                  style: textStyle,
                                )
                              : Text(
                                  date,
                                  style: textStyle,
                                ),
                          onTap: () {
                            _selectDate(context);
                          }),
                      Divider(),
                      ListTile(
                        leading: Text("Gender"),
                        trailing: (gender == null)
                            ? Text("....")
                            : (gender == 0)
                                ? Text(
                                    "Male",
                                    style: textStyle,
                                  )
                                : Text(
                                    "Female",
                                    style: textStyle,
                                  ),
                        onTap: () async {
                          int previousValue = gender;
                          int selectedGender = await showDialog(
                              context: context,
                              builder: (context) => RadioSelector(
                                    title: "Select Gender",
                                    radio1: "Male",
                                    radio2: "Female",
                                    value: gender,
                                  ));
                          int toSave = (selectedGender == null)
                              ? previousValue
                              : selectedGender;
                          await spHelper.saveInt(spKey.gender, toSave);
                          setState(() {
                            gender = toSave;
                          });
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Text("Unit"),
                        trailing: (unit == null)
                            ? Text("....")
                            : (unit == 0)
                                ? Text(
                                    "cm/kg",
                                    style: textStyle,
                                  )
                                : Text(
                                    "in/lbs",
                                    style: textStyle,
                                  ),
                        onTap: () async {
                          int previousValue = unit;
                          int selectedUnit = await showDialog(
                              context: context,
                              builder: (context) => RadioSelector(
                                    title: "Select Unit",
                                    radio2: "inch/lbs",
                                    radio1: "cm/kg",
                                    value: unit,
                                  ));
                          int toSave = (selectedUnit == null)
                              ? previousValue
                              : selectedUnit;
                          await spHelper.saveInt(spKey.unit, toSave);
                          setState(() {
                            unit = toSave;
                          });
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Text("Height"),
                        trailing: (unit == null)
                            ? Text(".....")
                            : (unit == 0)
                                ? Text(
                                    (heightValue == null)
                                        ? "....."
                                        : "$heightValue cm",
                                    style: textStyle,
                                  )
                                : Text(
                                    (feetHeight == null)
                                        ? "..."
                                        : "${feetHeight.round().toString()} feet ${inchHeight.toStringAsFixed(2)} inch",
                                    style: textStyle,
                                  ),
                        onTap: () async {
                          double previousValue = heightValue;
                          double initVal = 0;
                          double value = await showDialog(
                              context: context,
                              builder: (context) => HeightWeightSelector(
                                    title: "Height",
                                    label1: "cm",
                                    label2: "feet",
                                    controller1:heightValue==null? initVal.toString(): heightValue.toStringAsFixed(2),
                                    controller2:feetHeight==null?initVal.toString(): feetHeight.round().toString(),
                                    controller3:inchHeight==null?initVal.toString(): inchHeight.toStringAsFixed(2),
                                    selected: unit,
                                  ));
                          double toSave =
                              (value == null) ? previousValue : value;
                          await spHelper.saveDouble(spKey.height, toSave);
                          setState(() {
                            heightValue = toSave;
                            feetHeight = (toSave / 2.54) / 12;
                            inchHeight = (feetHeight - feetHeight.toInt()) * 12;
                          });
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Text("Weight"),
                        trailing: Text(
                          (weightValue == null)
                              ? "....."
                              : (unit == 0)
                                  ? "${weightValue.toStringAsFixed(2)} kg"
                                  : "${lbsWeight.round()} lbs",
                          style: textStyle,
                        ),
                        onTap: () async {
                          double previousValue = weightValue;
                          double initVal = 0;
                          double value = await showDialog(
                              context: context,
                              builder: (context) => HeightWeightSelector(
                                    title: "Weight",
                                    label1: "kg",
                                    label2: "lbs",
                                    selected: unit,
                                    controller1:(weightValue==null)?initVal.toString(): weightValue.toStringAsFixed(2),
                                    derivedController1:lbsWeight==null ? initVal.toString():
                                        lbsWeight.round().toString(),
                                  ));
                          DateTime selectedDate = DateTime.now();
                          double toSave =
                              (value == null) ? previousValue : value;
                          await spHelper.saveDouble(spKey.weight, toSave);
                          String key = DateFormat.yMd().format(selectedDate).toString();
                          WeightModel weightModel = WeightModel(
                              selectedDate.toIso8601String(), toSave, key);
                          if (weightModel.weight == null) return;
                          await weightDatabaseHelper.addWeight( toSave, weightModel, key);
                          setState(() {
                            weightValue = toSave;
                            lbsWeight = toSave * 2.20462;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text("Save"),
              color: Colors.purple.shade400,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}

class NameSelector extends StatelessWidget {
  final String name;

  NameSelector({this.name});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameInputController =
        TextEditingController(text: name);
    return AlertDialog(
      title: Text("Name"),
      content: TextField(
        controller: _nameInputController,
      ),
      actions: [
        RaisedButton(
            child: Text("Submit"),
            onPressed: () =>
                Navigator.of(context).pop(_nameInputController.text.toString()))
      ],
    );
  }
}

class RadioSelector extends StatefulWidget {
  final String title;
  final String radio1;
  final String radio2;
  final int value;

  RadioSelector({this.title, this.radio1, this.radio2, this.value});

  @override
  _RadioSelectorState createState() => _RadioSelectorState();
}

class _RadioSelectorState extends State<RadioSelector> {
  int radioValue = 2;

  @override
  void initState() {
    radioValue = (widget.value == null) ? 2 : widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        height: 112,
        child: Column(
          children: [
            RadioListTile(
              onChanged: (val) {
                setState(() {
                  radioValue = val;
                  print(val);
                });
              },
              groupValue: radioValue,
              value: 0,
              title: Text(widget.radio1),
              activeColor: Colors.red,
            ),
            RadioListTile(
              onChanged: (val) {
                setState(() {
                  radioValue = val;
                  print(val);
                });
              },
              groupValue: radioValue,
              value: 1,
              title: Text(widget.radio2),
              activeColor: Colors.pink,
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop(radioValue);
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}

