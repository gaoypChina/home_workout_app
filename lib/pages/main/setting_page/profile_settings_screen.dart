import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
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
      int feet = value ~/ 30.48;
      double inch = (value - (feet * 30.48)) * 0.393701;
      if (inch == 12) {
        inch = 0;
        feet = feet++;
      }

      setState(() {
        feetHeight = feet.toDouble();
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
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    _selectDate() async {
      final DateTime picked = await showRoundedDatePicker(

        theme:isDark?ThemeData.dark(): ThemeData(primaryColor: Colors.blue.shade700),
        context: context,
        height: MediaQuery.of(context).size.height * .4,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 110),
        lastDate: DateTime.now(),
        borderRadius: 16,
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
      // Colors.blue.shade700,
      // Colors.blue.shade700,
      // Colors.blue.shade700,
      // Colors.blue.shade700,
      // Colors.blue.shade700,
      // Colors.blue.shade700,
      Colors.red,
      Colors.green,
      Colors.amberAccent,
      Colors.orange,
      Colors.purpleAccent,
      Colors.orangeAccent,
    ];

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      appBar:

      AppBar(


        title: Text(
          "Profile",
        style: TextStyle(color: isDark?Colors.white:Colors.black)),

        actions: [
          TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(right: 18)),
            child: Text("Save",style: TextStyle(color: Colors.blue.shade700),),
              onPressed: () {
                Navigator.of(context).pop();
                constants.getToast("Profile Saved Successfully");
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Text(
            //       "Add your profile details and get more relevant exercise."),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            CustomProfileTile(
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
              child: CustomProfileTile(
                title: "Date of Birth",
                subTitle: (date == null) ? "Select your birthday" : date,
                onPressed: () {
                  _selectDate();
                },
                icon: Icons.cake,
                iconColor: iconColor[1],
              ),
            ),
            CustomProfileTile(
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
            CustomProfileTile(
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
            CustomProfileTile(
              title: "Height",
              subTitle: (unit == null)
                  ? "Enter your height"
                  : (unit == 0)
                      ? (heightValue == null)
                          ? ""
                          : "$heightValue cm"
                      : (feetHeight == null)
                          ? ""
                          : "${feetHeight.round().toString()} feet ${inchHeight.toInt()} inch",
              onPressed: () async {
                double previousValue = heightValue;
                double initVal = 0;
                double value = await showDialog(
                    context: context,
                    builder: (context) => HeightSelector(
                          height: heightValue == null ? initVal : heightValue,
                          unitValue: unit,
                        ));
                double toSave = (value == null) ? previousValue : value;
                await spHelper.saveDouble(spKey.height, toSave);
                setState(() {
                  heightValue = toSave;
                  feetHeight = (toSave ~/ 30.48).toDouble();
                  inchHeight = (toSave - (feetHeight * 30.48)) * 0.393701;
                  if (inchHeight == 12) {
                    inchHeight = 0;
                    feetHeight = feetHeight++;
                  }
                  // feetHeight = ((toSave / 2.54) / 1o2);
                  // inchHeight = (feetHeight - feetHeight.toInt()) * 12;
                });
              },
              icon: AntDesign.barchart,
              iconColor: iconColor[4],
            ),
            CustomProfileTile(
              title: "Weight",
              subTitle: (weightValue == null)
                  ? "Enter your weight"
                  : (unit == 0)
                      ? "${weightValue.toStringAsFixed(2)} kg"
                      : "${lbsWeight.round()} lbs",
              onPressed: () async {
                double previousValue = weightValue;
                double value = await showDialog(
                    context: context,
                    builder: (context) => WeightSelector(
                          weight: weightValue,
                          weightIndex: unit,
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
              "Save",
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
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
          child: Text("Save",
              style: textTheme.button.copyWith(color: Colors.blue.shade700)),
        ),
      ],
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final IconData icon;
  final Function onPressed;
  final Color iconColor;


  CustomProfileTile(
      {this.title,
      this.subTitle,
      this.backgroundColor,
      this.icon,
      this.onPressed,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;



    return ListTile(

      contentPadding: EdgeInsets.only(left: 24,right: 30),

      title: Text(title),
      leading: Icon(icon,color: iconColor,),
      onTap: onPressed,
      subtitle: Text(subTitle,style: TextStyle(color:isDark? Colors.white:Colors.black,fontSize: 15),),
      trailing: constants.trailingIcon,

    );

  }
}
