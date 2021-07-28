import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/components/height_weightSelector.dart';
import 'package:intl/intl.dart';
import '../../../helper/sp_helper.dart';
import '../../../main.dart';

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



    List<Color> iconColor = [
      Colors.blue.shade700,
      Colors.blue.shade700,
      Colors.blue.shade700,
      Colors.blue.shade700,
      Colors.blue.shade700,
      Colors.blue.shade700,
      // Colors.red.shade700,
      // Colors.green.shade700,
      // Colors.cyan.shade700,
      // Colors.teal.shade700,
      // Colors.orangeAccent.shade700,
    ];

    return Scaffold(
      appBar:

      AppBar(
        leading: IconButton(
          onPressed:()=> Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back,color: constants.appBarContentColor,),
          color: constants.appBarContentColor,
        ),
        title: Text(
          "Profile",
        style: TextStyle(color: constants.appBarContentColor)),
        backgroundColor: constants.appBarColor,
        elevation: 5,
        actions: [
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(right: 18)),
              child: Text(
                "Save",
                style: TextStyle(color: constants.appBarContentColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                constants.getToast("Profile Saved Successfully");
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                    "Add your profile details and get more relevant exercise "),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTile(
                backgroundColor: constants.tileColor,
                title: "Name",
                subTitle: (name != null) ? name : "Enter your name",
                onPressed: () async {
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
                icon: Icons.edit,
                iconColor: iconColor[0],
              ),
              Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Colors.blue.shade700),
                child: CustomTile(
                  backgroundColor: constants.tileColor,
                  title: "Birthday",
                  subTitle: (date == null) ? "Select your birthday" : date,
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icons.cake,
                  iconColor: iconColor[1],
                ),
              ),
              CustomTile(
                backgroundColor: constants.tileColor,
                title: "Gender",
                subTitle: (gender == null)
                    ? "Select your gender"
                    : (gender == 0)
                        ? "Male"
                        : "Female",
                onPressed: () async {
                  int previousValue = gender;
                  int selectedGender = await showDialog(
                      context: context,
                      builder: (context) => RadioSelector(
                            title: "Select Gender",
                            radio1: "Male",
                            radio2: "Female",
                            value: gender,
                          ));
                  int toSave =
                      (selectedGender == null) ? previousValue : selectedGender;
                  await spHelper.saveInt(spKey.gender, toSave);
                  setState(() {
                    gender = toSave;
                  });
                },
                icon: Icons.male,
                iconColor: iconColor[2],
              ),
              CustomTile(
                backgroundColor: constants.tileColor,
                title: "Unit",
                subTitle: (unit == null)
                    ? "Select unit"
                    : (unit == 0)
                        ? "cm/kg"
                        : "in/lbs",
                onPressed: () async {
                  int previousValue = unit;
                  int selectedUnit = await showDialog(
                      context: context,
                      builder: (context) => RadioSelector(
                            title: "Select Unit",
                            radio2: "inch/lbs",
                            radio1: "cm/kg",
                            value: unit,
                          ));
                  int toSave =
                      (selectedUnit == null) ? previousValue : selectedUnit;
                  await spHelper.saveInt(spKey.unit, toSave);
                  setState(() {
                    unit = toSave;
                  });
                },
                icon: Icons.linear_scale_sharp,
                iconColor: iconColor[3],
              ),
              CustomTile(
                backgroundColor: constants.tileColor,
                title: "Height",
                subTitle: (unit == null)
                    ? "Enter your height"
                    : (unit == 0)
                        ? (heightValue == null)
                            ? ""
                            : "$heightValue cm"
                        : (feetHeight == null)
                            ? ""
                            : "${feetHeight.round().toString()} feet ${inchHeight.toStringAsFixed(2)} inch",
                onPressed: () async {
                  double previousValue = heightValue;
                  double initVal = 0;
                  double value = await showDialog(
                      context: context,
                      builder: (context) => HeightWeightSelector(
                            title: "Height",
                            label1: "cm",
                            label2: "feet",
                            controller1: heightValue == null
                                ? initVal.toString()
                                : heightValue.toStringAsFixed(2),
                            controller2: feetHeight == null
                                ? initVal.toString()
                                : feetHeight.round().toString(),
                            controller3: inchHeight == null
                                ? initVal.toString()
                                : inchHeight.toStringAsFixed(2),
                            selected: unit,
                          ));
                  double toSave = (value == null) ? previousValue : value;
                  await spHelper.saveDouble(spKey.height, toSave);
                  setState(() {
                    heightValue = toSave;
                    feetHeight = (toSave / 2.54) / 12;
                    inchHeight = (feetHeight - feetHeight.toInt()) * 12;
                  });
                },
                icon: AntDesign.barchart,
                iconColor: iconColor[4],
              ),
              CustomTile(
                backgroundColor: constants.tileColor,
                title: "Weight",
                subTitle: (weightValue == null)
                    ? "Enter your weight"
                    : (unit == 0)
                        ? "${weightValue.toStringAsFixed(2)} kg"
                        : "${lbsWeight.round()} lbs",
                onPressed: () async {
                  double previousValue = weightValue;
                  double initVal = 0;
                  double value = await showDialog(
                      context: context,
                      builder: (context) => HeightWeightSelector(
                            title: "Weight",
                            label1: "kg",
                            label2: "lbs",
                            selected: unit,
                            controller1: (weightValue == null)
                                ? initVal.toString()
                                : weightValue.toStringAsFixed(2),
                            derivedController1: lbsWeight == null
                                ? initVal.toString()
                                : lbsWeight.round().toString(),
                          ));
                  DateTime selectedDate = DateTime.now();
                  double toSave = (value == null) ? previousValue : value;
                  await spHelper.saveDouble(spKey.weight, toSave);
                  String key = DateFormat.yMd().format(selectedDate).toString();
                  WeightModel weightModel =
                      WeightModel(selectedDate.toIso8601String(), toSave, key);
                  if (weightModel.weight == null) return;
                  await weightDatabaseHelper.addWeight(
                      toSave, weightModel, key);
                  setState(() {
                    weightValue = toSave;
                    lbsWeight = toSave * 2.20462;
                  });
                },
                icon: MaterialCommunityIcons.weight,
                iconColor: iconColor[5],
              ),
              SizedBox(
                height: 50,
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
    Color contentColor = Colors.blue.shade700;
    TextEditingController _nameInputController =
        TextEditingController(text: name);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      title: Text("Enter your Name"),
      content: TextField(
        autofocus: true,
        controller: _nameInputController,
        enabled: true,
        cursorColor: contentColor,
        autocorrect: false,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: contentColor),
              borderRadius: BorderRadius.circular(16),
            ),
            fillColor: Colors.blue.shade50,
            enabled: true,
            labelText: "Name",
            labelStyle:
                TextStyle(color: contentColor, fontWeight: FontWeight.w700)),
      ),
      actions: [
        TextButton(
            child: Text(
              "Cancel",
              style: textTheme.button.copyWith(color: Colors.grey),
            ),
            onPressed: () => Navigator.of(context).pop()),
        TextButton(
            child: Text(
              "Submit",
              style: textTheme.button.copyWith(color: contentColor),
            ),
            onPressed: () => Navigator.of(context)
                .pop(_nameInputController.text.toString())),
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
        height: 120,
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
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel",
              style: textTheme.button.copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(radioValue);
          },
          child: Text("Submit",
              style: textTheme.button.copyWith(color: Colors.blue.shade700)),
        ),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final IconData icon;
  final Function onPressed;
  final Color iconColor;

  CustomTile(
      {this.title,
      this.subTitle,
      this.backgroundColor,
      this.icon,
      this.onPressed,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey.shade700);
    var titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
    );

    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 70,
            color: backgroundColor,
            child: Row(
              children: <Widget>[
                Container(
                  color: iconColor,
                  width: 70,
                  height: 70,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                    onTap: onPressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: titleStyle,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(subTitle, style: textStyle)
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 22,
                ),
                SizedBox(width: 18),
              ],
            ),
          ),
        ));
  }
}
