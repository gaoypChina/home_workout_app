import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
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
  Constants constants = Constants();
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

    var textStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
    var titleStyle = TextStyle(
        fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black);
    Icon trailingIcon =  Icon(Icons.arrow_forward_ios);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [TextButton(
          child: Text("Save"),
          onPressed: () => Navigator.of(context).pop(),
        ),],
        leading: TextButton(
          child: Icon(
            Icons.keyboard_backspace_sharp,
            color: Colors.black,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Add your profile details and get more relevante exercise "),
              ),
              SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: Text("Name",style: titleStyle,),
                leading:  Icon(Icons.edit),
                trailing: trailingIcon,
                subtitle: (name != null)
                    ? Text(
                        name,
                        style: textStyle,
                      )
                    : Text(
                        "",
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
            SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                title:Text("Birthday",style: titleStyle,) ,
                  leading: Icon(Icons.calendar_today_rounded),
                  trailing: trailingIcon,
                  subtitle: (date == null)
                      ? Text(
                          "",
                          style: textStyle,
                        )
                      : Text(
                          date,
                          style: textStyle,
                        ),
                  onTap: () {
                    _selectDate(context);
                  }),
              SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: Text("Gender",style: titleStyle,),
                leading: Icon(Icons.male),
                trailing: trailingIcon,
                subtitle: (gender == null)
                    ? Text("")
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
              SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: Text("Unit",style: titleStyle,),
                leading: Icon(Icons.linear_scale_sharp),
                trailing: trailingIcon,

                subtitle: (unit == null)
                    ? Text("")
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
              SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: Text("Height",style: titleStyle,),
                leading: Icon(AntDesign.barchart),
                trailing: trailingIcon,

                subtitle: (unit == null)
                    ? Text("")
                    : (unit == 0)
                        ? Text(
                            (heightValue == null)
                                ? ""
                                : "$heightValue cm",
                            style: textStyle,
                          )
                        : Text(
                            (feetHeight == null)
                                ? ""
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
              SizedBox(height: 10,),
              ListTile(
                tileColor: constants.tileColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                title: Text("Weight",style: titleStyle,),
                leading: Icon(MaterialCommunityIcons.weight),
                trailing: trailingIcon,

                subtitle: Text(
                  (weightValue == null)
                      ? ""
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
        enabled: true,
        decoration: InputDecoration(
          labelText: "Enter your name",
        ),

      ),
      actions: [
        ElevatedButton(
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
              activeColor: Colors.blue,
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
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(radioValue);
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}

