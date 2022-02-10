import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/components/height_weightSelector.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/models/weight_model.dart';
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
   String? name;
   String? date;
   int? gender;
   int? unit;
   double? heightValue;
   double? weightValue;
   DateTime? actualDate;
  bool showSaveButton = false;

  //derived values

  late double? lbsWeight;
  late double? feetHeight;
  late double? inchHeight;

  getSavedData() async {
    String? temp = await spHelper.loadString(spKey.date);
    if (temp == null) {
      date = null;
    } else {
      String formatedDay = DateFormat.yMMMd().format(DateTime.parse(temp));
      date = formatedDay;
    }

    name = await spHelper.loadString(spKey.name);

    gender = await spHelper.loadInt(spKey.gender);

    unit = await spHelper.loadInt(spKey.unit);

    double? tempHeight = await spHelper.loadDouble(spKey.height);
    if (tempHeight == null) {
      feetHeight = null;
      inchHeight = null;
      heightValue = null;
    } else {
      int feet = tempHeight ~/ 30.48;
      double inch = (tempHeight - (feet * 30.48)) * 0.393701;
      if (inch == 12) {
        inch = 0;
        feet = feet++;
      }

      setState(() {
        feetHeight = feet.toDouble();
        inchHeight = inch;
        heightValue = tempHeight;
      });
    }

    double? tempWeight = await spHelper.loadDouble(spKey.weight);
    if (tempWeight == null) {
      weightValue = null;
      lbsWeight = null;
    } else {
      weightValue = tempWeight;
      lbsWeight = tempWeight * 2.20462;
    }

    setState(() {});
  }

  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
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
      final DateTime? picked = await showRoundedDatePicker(
        theme: isDark
            ? ThemeData.dark()
            : ThemeData(primaryColor: Colors.blue.shade700),
        context: context,
        height: MediaQuery.of(context).size.height * .4,
        initialDate: DateTime(2000, 08, 12),
        firstDate: DateTime(DateTime.now().year - 110),
        lastDate: DateTime(DateTime.now().year - 12),
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
      Colors.red,
      Colors.green,
      Colors.amberAccent.shade200,
      Colors.orange,
      Colors.red,
      Colors.orangeAccent,
    ];

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      appBar:

      AppBar(
        backgroundColor: isDark?Colors.black:Colors.white,
        title: Text(
          "Profile",
        style: TextStyle(color: isDark?Colors.white:Colors.black)),

        actions: [
          showSaveButton ?   TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.only(right: 18)),
            child: Padding(
              padding: const EdgeInsets.only(right:12.0),
              child: Text("Save",style: TextStyle(color: Colors.blue.shade700),),
            ),
              onPressed: () {
                Navigator.of(context).pop();
                constants.getToast("Profile Saved Successfully",isDark);
              }):Container(),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            CustomProfileTile(

              title: "Name",
              data: name,
              subTitle:  name ?? "Enter your name",
              onPressed: () async {
                String previousValue = name??"";
                String? a = await showDialog(
                    context: context,
                    builder: (context) => NameSelector(
                          name: name??"",
                        ));
                String toSave = (a == null) ? previousValue : a;
                await spHelper.saveString(spKey.name, toSave);
                setState(() {
                  name = toSave;
                  showSaveButton = true;
                });
              },
              icon: Icons.edit,
              iconColor: iconColor[0],
            ),
            CustomProfileTile(
                title: "Date of Birth",
                data:date,
                subTitle: date ?? "Select your birthday",
                onPressed: () {
                  _selectDate();
                  setState(() {
                    showSaveButton = true;
                  });
                },
                icon: Icons.cake,
                iconColor: iconColor[1],
              ),
            CustomProfileTile(
              data:gender,
              title: "Gender",
              subTitle: (gender == null)
                  ? "Select your gender"
                  : (gender == 0)
                      ? "Male"
                      : "Female",
              onPressed: () async {
                int? previousValue = gender;
                int? selectedGender = await showDialog(
                    context: context,
                    builder: (context) => RadioSelector(
                          title: "Select Gender",
                          radio1: "Male",
                          radio2: "Female",
                          value: gender??0,
                        ));
                int? toSave =
                    selectedGender ?? previousValue;
                await spHelper.saveInt(spKey.gender, toSave??0);
                setState(() {
                  gender = toSave;
                  showSaveButton = true;
                });
              },
              icon: Icons.male,
              iconColor: iconColor[2],
            ),
            CustomProfileTile(
              title: "Unit",
              data: unit,
              subTitle: (unit == null)
                  ? "Select unit"
                  : (unit == 0)
                      ? "Cm/Kg"
                      : "Inch/Lbs",
              onPressed: () async {
                int? previousValue = unit;
                int? selectedUnit = await showDialog(
                    context: context,
                    builder: (context) => RadioSelector(
                          title: "Select Unit",
                          radio2: "Inch/Lbs",
                          radio1: "Cm/Kg",
                          value: unit??0,
                        ));
                int? toSave =
                    selectedUnit ?? previousValue;
                await spHelper.saveInt(spKey.unit, toSave??0);
                setState(() {
                  unit = toSave;
                  showSaveButton = true;
                });
              },
              icon: Icons.linear_scale_sharp,
              iconColor: iconColor[3],
            ),
            CustomProfileTile(
              title: "Height",
              data: unit,
              subTitle: (unit == null)
                  ? "Enter your height"
                  : (unit == 0)
                      ? (heightValue == null)
                          ? ""
                          : "$heightValue cm"
                      : (feetHeight == null)
                          ? ""
                          : "${feetHeight!.round().toString()} feet ${inchHeight!.toInt()} inch",
              onPressed: () async {
                double? previousValue = heightValue;
                double initVal = 0;
                double? value = await showDialog(
                    context: context,
                    builder: (context) => HeightSelector(
                          height: heightValue ?? initVal,
                          unitValue: unit??0,
                        ));
                double? toSave = value ?? previousValue;
                await spHelper.saveDouble(spKey.height, toSave??0);
                setState(() {
                  showSaveButton = true;
                  if(toSave == null){
                  heightValue = toSave;
                  feetHeight = (toSave! ~/ 30.48).toDouble();
                  inchHeight = (toSave - (feetHeight! * 30.48)) * 0.393701;
                  if (inchHeight == 12) {
                    inchHeight = 0;
                    feetHeight = feetHeight! + 1;
                  }
                }});
              },
              icon: FontAwesomeIcons.chartBar,
              iconColor: iconColor[4],
            ),
            CustomProfileTile(
              title: "Weight",
              data: weightValue,
              subTitle: (weightValue == null)
                  ? "Enter your weight"
                  : (unit == 0)
                      ? "${weightValue!.toStringAsFixed(2)} Kg"
                      : "${lbsWeight!.round()} Lbs",
              onPressed: () async {
                double previousValue = weightValue??0;
                double? value = await showDialog(
                    context: context,
                    builder: (context) => WeightSelector(
                          weight: weightValue??0,
                          weightIndex: unit??0,
                        ));
                DateTime selectedDate = DateTime.now();
                double toSave = value ?? previousValue;
                await spHelper.saveDouble(spKey.weight, toSave);
                String key = DateFormat.yMd().format(selectedDate).toString();
                WeightModel weightModel =
                    WeightModel(selectedDate.toIso8601String(), toSave, key);
                if (weightModel.weight == null) return;
                await weightDatabaseHelper.addWeight(
                    toSave, weightModel, key);
                setState(() {
                  showSaveButton = true;
                  weightValue = toSave;
                  lbsWeight = toSave * 2.20462;
                });
              },
              icon: FontAwesomeIcons.weight,
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

  NameSelector({required this.name});

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
              style: textTheme.button!.copyWith(color: Colors.grey),
            ),
            onPressed: () => Navigator.of(context).pop()),
        TextButton(
            child: Text(
              "Save",
              style: textTheme.button!.copyWith(color: contentColor),
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

  RadioSelector(
      {required this.title,
      required this.radio1,
      required this.radio2,
      required this.value});

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
              onChanged: (int? val) {
                setState(() {
                  radioValue = val!;
                  print(val);
                });
              },
              groupValue: radioValue,
              value: 0,
              title: Text(widget.radio1),
            ),
            RadioListTile(
              onChanged: (int? val) {
                setState(() {
                  radioValue = val??0;
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
              style: textTheme.button!.copyWith(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(radioValue);
          },
          child: Text("Save",
              style: textTheme.button!.copyWith(color: Colors.blue.shade700)),
        ),
      ],
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function onPressed;
  final Color iconColor;
  final  data;

  CustomProfileTile(
      {required this.title,
      required this.subTitle,
      required this.icon,
      required this.onPressed,
      required this.data,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;


    return ListTile(

      contentPadding: EdgeInsets.only(left: 24, right: 30),

      title: Text(title),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      onTap:()=> onPressed(),
      trailing: Text(
          subTitle.length > 20 ? '${subTitle.substring(0, 20)}...' : subTitle,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: data.toString() == "null"
                ? Colors.grey
                : isDark
                    ? Colors.white
                    : Colors.black,
            fontSize: data.toString() == "null" ? 12 : 14,
          )),
      // trailing: constants.trailingIcon,

    );

  }
}
