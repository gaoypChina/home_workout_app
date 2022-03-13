import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/models/bmi_remark.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/pages/workout_page/report_page.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'bmi_picker.dart';

class BmiCard extends StatefulWidget {
  final bool showBool;

  BmiCard({required this.showBool});

  @override
  _BmiCardState createState() => _BmiCardState();
}

class _BmiCardState extends State<BmiCard> {
  SpHelper _spHelper = new SpHelper();
  SpKey _spKey = new SpKey();
  var weightDb = WeightDatabaseHelper();
  Constants constants = Constants();

  bool _isLoading = true;

  double? weight = 0;
  double? height = 0;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    weight = await _spHelper.loadDouble(_spKey.weight);
    height = await _spHelper.loadDouble(_spKey.height);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    double bmi = 0;

    double _calcBmi(double height, double weight) {
      return weight / (height * height);
    }

    getPadValue(double bmi) {
      double toReturn = 0;
      if (bmi >= 17 && bmi < 18.5) {
        toReturn = 10;
      } else if (bmi >= 18.5 && bmi < 25) {
        toReturn = 22;
      } else if (bmi >= 25 && bmi < 30) {
        toReturn = 24;
      } else if (bmi >= 30 && bmi < 35) {
        toReturn = 26;
      } else if (bmi >= 35 && bmi < 40) {
        toReturn = 28;
      } else if (bmi >= 40) {
        toReturn = 29;
      }

      return toReturn+1;
    }

    BmiRemark _getRemark(double bmi) {
      BmiRemark bmiRemark;
      if (bmi < 16) {
        bmiRemark = BmiRemark(
            remark: "Very severely Underweight", color: Colors.redAccent);
      } else if (bmi >= 16 && bmi <= 16.9) {
        bmiRemark =
            BmiRemark(remark: "Severely underweight", color: Colors.grey);
      } else if (bmi >= 17 && bmi <= 18.4) {
        bmiRemark = BmiRemark(remark: "Underweight", color: Colors.blue);
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        bmiRemark = BmiRemark(remark: "Healthy weight", color: Colors.green);
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiRemark = BmiRemark(remark: "Overweight", color: Colors.orange);
      } else if (bmi >= 30 && bmi <= 34.9) {
        bmiRemark = BmiRemark(remark: "Obese class I", color: Colors.redAccent);
      } else if (bmi >= 35 && bmi <= 39.9) {
        bmiRemark = BmiRemark(remark: "Obese class II", color: Colors.red);
      } else {
        bmiRemark = BmiRemark(remark: "Obese class III", color: Colors.red);
      }
      return bmiRemark;
    }


    showBmiSheet() {
      getWeightDetail(
          {required String title,
          required String value,
          required Color color}) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                size: 24.0,
                color: color,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    TextStyle(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              )
            ],
          ),
        );
      }

      return showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          extendBody: true,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [ 0.7, 1.0],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          builder: (context, state) {
            return Material(
              color: Theme.of(context).cardColor,
              child: SingleChildScrollView(
              child:    Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18,),
                  Container(

                    height: 30,
                    child: Row(
                      children: [
                        Text(""),
                        Spacer(),
                        Text(
                          "Weight Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        Spacer(),
                        Text(
                          "Index",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        SizedBox(
                          width: 18,
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  getWeightDetail(
                      title: "Very Severely Underweight",
                      value: "<= 16",
                      color: Colors.grey),
                  Divider(),
                  getWeightDetail(
                      title: "Severely Underweight",
                      value: "16 - 16.9",
                      color: Colors.grey.shade500),
                  Divider(),
                  getWeightDetail(
                      title: "Underweight",
                      value: "17 - 18.4",
                      color: Colors.blue),
                  Divider(),
                  getWeightDetail(
                      title: "Healthy weight",
                      value: "18.5 - 24.9",
                      color: Colors.green),
                  Divider(),
                  getWeightDetail(
                      title: "Overweight",
                      value: "25 - 29.9",
                      color: Colors.orange),
                  Divider(),
                  getWeightDetail(
                      title: "Obese class I",
                      value: "30 - 34.9",
                      color: Colors.redAccent),
                  Divider(),
                  getWeightDetail(
                      title: "Obese class II",
                      value: "35 - 39.9",
                      color: Colors.red),
                  Divider(),
                  getWeightDetail(
                      title: "Obese class III",
                      value: ">=40",
                      color: Colors.red.shade800),
                  Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                    child: Text(
                        "The body mass index(BMI) Calculator can be used to calculate BMI value and corresponding weight status."),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                          left: 18.0, right: 18, bottom: 4),
                      child: Text("Healthy BMI Range",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0,right: 18),
                    child: Text(
                        "The world health organization\'s (WHO) recommended healthy BMI range is 18.5-25 for both male and female",
                        ),
                  ),
                  SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
    }

    late BmiRemark remark;

    if (height != null && weight != null) {
      bmi = double.parse(_calcBmi(height! / 100, weight!).toStringAsFixed(2));
      print(bmi);
      remark = _getRemark(bmi);
    }

    var size = MediaQuery.of(context).size;
    double width = size.width;
    double borderWidth = 2;
    double bmiWidth = width - 36 - borderWidth * 5;
    double oneUnit = bmiWidth / 25;
    getBorder() {
      return Container(
        height: 50,
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.2),
        width: borderWidth,
      );
    }

    getEditButton(String title) {
      return TextButton(style: ButtonStyle(padding:MaterialStateProperty.all(EdgeInsets.all(0),)),
          onPressed: () async {
            var res = await showDialog(
                context: context,
                builder: (context) {
                  return BMIPicker(
                    height: height,
                    weight: weight,
                  );
                });

            DateTime selectedDate = DateTime.now();
            double toSave = (res[1] == null) ? weight : res[1];
            await spHelper.saveDouble(spKey.weight, toSave);
            String key = DateFormat.yMd().format(selectedDate).toString();
            WeightModel weightModel =
            WeightModel(selectedDate.toIso8601String(), toSave, key);
            if (weightModel.weight == null) return;
            await weightDb.addWeight(
                toSave, weightModel, key);

            setState(() {
              _spHelper.saveDouble(_spKey.height, res[0]);
              _spHelper.saveDouble(_spKey.weight, res[1]);
              height = res[0];
              weight = res[1];
            });
          },
          child: Text(title));
    }

    getBottomText(String text) {
      return Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      );
    }

    getArrow() {
      getContainer(){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),

          ),
          height: 12.2,
          width: 2.0,
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
           Icons.arrow_upward,
            size: 20,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          SizedBox(height: 2,),
          getContainer(),
          SizedBox(height: 4,),
          getContainer(),
          SizedBox(height: 4,),
          getContainer(),
          SizedBox(height: 4,),




        ],
      );
    }

    getBmiStrip() {
      return InkWell(
        onTap: () => showBmiSheet(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: bmiWidth + borderWidth * 5 + 5,
              child: Row(
                children: [
                  Container(
                    width: oneUnit + 5,
                    color: Colors.grey,
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 2.5,
                    color: Colors.blue,
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 6.5,
                    color: Colors.green,
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.orange,
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.redAccent,
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                getBottomText("16"),
                Container(
                  width: oneUnit - 7,
                  color: Colors.grey,
                ),
                getBottomText("17"),
                Container(
                  width: oneUnit * 2.5 - 15,
                  color: Colors.blue,
                ),
                getBottomText("18.5"),
                Container(
                  width: oneUnit * 6.5 - 12,
                  color: Colors.green,
                ),
                getBottomText("25"),
                Container(
                  width: oneUnit * 5 - 12,
                  color: Colors.orange,
                ),
                getBottomText("30"),
                Container(
                  width: oneUnit * 5 - 10,
                  color: Colors.redAccent,
                ),
                getBottomText("35"),
                Container(
                  width: oneUnit * 5 - 19,
                  color: Colors.red,
                ),
                getBottomText("40"),
              ],
            ),
          ],
        ),
      );
    }

    getMyHealth(String height, String weight) {
      getWeightDetail(
          {required String title,
          required String value,
          required Color color}) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                size: 14.0,
                color: color,
              ),
              SizedBox(
                width: 10,
              ),
              Text(title),
              Spacer(),
              isLoading?CircularProgressIndicator():
              Text(value)
            ],
          ),
        );
      }
      return Container(
        child: Column(
          children: [
        Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 4),child:  Row(
              children: [
                Text(
                    "My Health",
                    style: Constants().titleStyle,
                  ),

                Spacer(),
                getEditButton("EDIT")
              ],
            ),),
            Column(
              children: [
                getWeightDetail(color: Colors.red,value: height,title: "Height"),
                getWeightDetail(color: Colors.blue,value: weight,title: "Weight"),
              ],)
          ],
        ),
      );
    }
    return (_isLoading)
        ? CircularProgressIndicator()
        : height == null || weight == null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Text("BMI Calculator", style: Constants().titleStyle),
                        Spacer(),
                        getEditButton("Edit")
                      ],
                    ),
                  ),
                  getBmiStrip(),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Add height and weight to calculate BMI",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
        )
        : Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 18.0,right: 2),
          child:
          Row(
                      children: [
                        Text("BMI Calculator", style: Constants().titleStyle),
                        Spacer(),
                        getEditButton("EDIT")
                      ],
                    ),
                  ),
                  (bmi >= 15 && bmi <= 40)
                      ? Row(
                          children: [
                            (bmi >= 35 && bmi <= 40)
                                ? SizedBox(
                                    width: (bmi - 16) * oneUnit +
                                        getPadValue(bmi) -
                                        8)
                                : SizedBox(
                                    width: (bmi - 16) * oneUnit +
                                        getPadValue(bmi)),
                            Text(
                              (bmi >= 35 && bmi <= 40)
                                  ? bmi.toStringAsFixed(1)
                                  : bmi.toStringAsFixed(1),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    height: 90,
                    child: Stack(
                      children: [
                        getBmiStrip(),
                        (bmi >= 16 && bmi <= 40)
                            ? Row(
                                children: [
                                  SizedBox(
                                      width: (bmi - 16) * oneUnit +
                                          getPadValue(bmi)),
                                  Container(
                                    child: getArrow(),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BMI : " + bmi.toStringAsFixed(1),
                          style: TextStyle(
                              color: remark.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("(${remark.remark})",
                          style: TextStyle(
                              color: remark.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ],
                  ),
        if (widget.showBool)   SizedBox(height: 10,),
        if (widget.showBool) constants.getDivider(context: context),
                  if (widget.showBool)
                    getMyHealth(height!.toInt().toString() + " Cm",
                        weight!.toInt().toString() + " Kg"),
                  if (widget.showBool) SizedBox(height: 20)
                ],
              );
  }
}
