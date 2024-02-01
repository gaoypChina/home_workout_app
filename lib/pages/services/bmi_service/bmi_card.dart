import 'package:flutter/material.dart';
import 'package:full_workout/pages/services/bmi_service/bmi_result_page.dart';
import '../../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../helper/weight_db_helper.dart';
import '../../../models/bmi_remark.dart';
import '../../../models/weight_model.dart';
import '../../../pages/workout_page/report_page.dart';
import 'package:intl/intl.dart';

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

      return toReturn + 1;
    }

    BmiRemark _getRemark(double bmi) {
      BmiRemark bmiRemark;
      if (bmi < 16) {
        bmiRemark = BmiRemark(
            remark: "Very severely Underweight", color: Colors.redAccent);
      } else if (bmi >= 16 && bmi <= 16.9) {
        bmiRemark = BmiRemark(
            remark: "Severely underweight", color: Colors.red.withOpacity(.8));
      } else if (bmi >= 17 && bmi <= 18.4) {
        bmiRemark = BmiRemark(
            remark: "Underweight", color: Colors.amber.withOpacity(.8));
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        bmiRemark = BmiRemark(
            remark: "Healthy weight", color: Colors.green.withOpacity(.8));
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiRemark = BmiRemark(
            remark: "Overweight", color: Colors.orange.withOpacity(.8));
      } else if (bmi >= 30 && bmi <= 34.9) {
        bmiRemark = BmiRemark(
            remark: "Obese class I", color: Colors.redAccent.withOpacity(.8));
      } else if (bmi >= 35 && bmi <= 39.9) {
        bmiRemark = BmiRemark(
            remark: "Obese class II", color: Colors.red.withOpacity(.8));
      } else {
        bmiRemark = BmiRemark(
            remark: "Obese class III", color: Colors.red.withOpacity(.8));
      }
      return bmiRemark;
    }


  late   BmiRemark remark;

    if (height != null && weight != null) {
      bmi = double.parse(_calcBmi(height! / 100, weight!).toStringAsFixed(2));
      print(bmi);
      remark = _getRemark(bmi);
    }

    var size = MediaQuery.of(context).size;
    double width = size.width;
    double borderWidth = 1.5;
    double bmiWidth = width - 36 - borderWidth * 5;
    double oneUnit = bmiWidth / 25;
    getBorder() {
      return Container(
        height: 50,
        color: Colors.grey.withOpacity(.1),
        width: borderWidth,
      );
    }

    getEditButton(String title) {
      return TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
            EdgeInsets.all(0),
          )),
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
            WeightModel weightModel = WeightModel(
              selectedDate.toIso8601String(),
              toSave,
              key,
              DateTime.now().millisecondsSinceEpoch,
            );
            await weightDb.addWeight(toSave, weightModel, key);

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
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
      );
    }

    getArrow() {
      getContainer() {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5),
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
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
          ),
          SizedBox(
            height: 2,
          ),
          getContainer(),
          SizedBox(
            height: 4,
          ),
          getContainer(),
          SizedBox(
            height: 4,
          ),
          getContainer(),
          SizedBox(
            height: 4,
          ),
        ],
      );
    }

    getBmiStrip() {
      return InkWell(
        // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (builder){
        //   return BmiResultPage(bmi: bmi,);
        // })),
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
                    color: Colors.red.withOpacity(.8),
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 2.5,
                    color: Colors.amber.withOpacity(.8),
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 6.5,
                    color: Colors.green.withOpacity(.8),
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.orange.withOpacity(.8),
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.redAccent.withOpacity(.8),
                  ),
                  getBorder(),
                  Container(
                    width: oneUnit * 5,
                    color: Colors.red.withOpacity(.8),
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
                  color: Colors.red.withOpacity(.8),
                ),
                getBottomText("17"),
                Container(
                  width: oneUnit * 2.5 - 15,
                  color: Colors.amber.withOpacity(.8),
                ),
                getBottomText("18.5"),
                Container(
                  width: oneUnit * 6.5 - 12,
                  color: Colors.green.withOpacity(.8),
                ),
                getBottomText("25"),
                Container(
                  width: oneUnit * 5 - 12,
                  color: Colors.orange.withOpacity(.8),
                ),
                getBottomText("30"),
                Container(
                  width: oneUnit * 5 - 10,
                  color: Colors.redAccent.withOpacity(.8),
                ),
                getBottomText("35"),
                Container(
                  width: oneUnit * 5 - 19,
                  color: Colors.red.withOpacity(.8),
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
              isLoading ? CircularProgressIndicator() : Text(value)
            ],
          ),
        );
      }

      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 4),
              child: Row(
                children: [
                  Text(
                    "My Health",
                    style: Constants().titleStyle,
                  ),
                  Spacer(),
                  getEditButton("EDIT")
                ],
              ),
            ),
            Column(
              children: [
                getWeightDetail(
                    color: Colors.red.withOpacity(.8),
                    value: height,
                    title: "Height"),
                getWeightDetail(
                    color: Colors.green.withOpacity(.8),
                    value: weight,
                    title: "Weight"),
              ],
            )
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
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(.8)),
                  ),
                  SizedBox(
                    height: 24,
                  )
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 2),
                    child: Row(
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
                                  fontWeight: FontWeight.w500, fontSize: 14),
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
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("(${remark.remark})",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ],
                  ),
                  if (widget.showBool)
                    SizedBox(
                      height: 10,
                    ),
                  if (widget.showBool) constants.getDivider(context: context),
                  if (widget.showBool)
                    getMyHealth(height!.toInt().toString() + " Cm",
                        weight!.toInt().toString() + " Kg"),
                  if (widget.showBool) SizedBox(height: 20)
                ],
              );
  }
}
