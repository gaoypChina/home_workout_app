import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../models/bmi_remark.dart';

class BmiResultPage extends StatefulWidget {
  final double bmi;

  const BmiResultPage({super.key, required this.bmi});

  @override
  State<BmiResultPage> createState() => _BmiResultPageState();
}

class _BmiResultPageState extends State<BmiResultPage> {
  ScrollController controller = ScrollController();

  BmiRemark _getRemark(double bmi) {
    BmiRemark bmiRemark;
    if (bmi < 16) {
      bmiRemark = BmiRemark(
          remark: "Very severely Underweight", color: Colors.redAccent);
    } else if (bmi >= 16 && bmi <= 16.9) {
      bmiRemark = BmiRemark(
          remark: "Severely underweight", color: Colors.red.withOpacity(.8));
    } else if (bmi >= 17 && bmi <= 18.4) {
      bmiRemark =
          BmiRemark(remark: "Underweight", color: Colors.amber.withOpacity(.8));
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      bmiRemark = BmiRemark(
          remark: "Healthy weight", color: Colors.green.withOpacity(.8));
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmiRemark =
          BmiRemark(remark: "Overweight", color: Colors.orange.withOpacity(.8));
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

  @override
  Widget build(BuildContext context) {
    getWeightDetail(
        {required String title, required String value, required Color color}) {
      return Row(
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
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          )
        ],
      );
    }

    buildBmiInfoCard() {
      var remark = _getRemark(widget.bmi);
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              "Your BMI is",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  Text(
                    widget.bmi.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    "Kg/M™",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white.withOpacity(.9)),
                  )
                ],
              ),
            ),
            Text(
              remark.remark,
              style: TextStyle(),
            )
          ],
        ),
      );
    }

    buildPersonInfoCard() {
      buildGender() {
        return Expanded(
          child: Column(
            children: [Icon(Icons.person), Text("Male")],
          ),
        );
      }

      buildDetail({required String title, required String detail}) {
        return Expanded(
          child: Column(
            children: [
              Text(
                detail,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade900),
              )
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.blue.withOpacity(.5))),
        child: Row(
          children: [
            buildGender(),
            buildDetail(title: 'Age', detail: '20'),
            buildDetail(title: 'Height', detail: '150'),
            buildDetail(title: 'Weight', detail: '70'),
          ],
        ),
      );
    }

    buildBmiInfoText() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            SizedBox(height: 18),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "A BMI of ",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.2,
                        color:
                            Theme.of(context).textTheme.displayLarge!.color)),
                TextSpan(
                    text: " 18.5-24.9 ",
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.2,
                        color:
                            Theme.of(context).primaryColor)),
                TextSpan(
                    text: " your friends",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color:
                            Theme.of(context).textTheme.displayLarge!.color)),
              ]),
            ),
            Text(
              "The body mass index(BMI) Calculator can be used to calculate BMI value and corresponding weight status.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 18),
            Text(
              "The world health organization\'s (WHO) recommended healthy BMI range is 18.5-25 for both male and female",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
      );
    }

    buildDetailTile() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Container(
              height: 30,
              child: Row(
                children: [
                  Text(""),
                  Spacer(),
                  Text(
                    "Weight Categories",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "Index",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
                title: "Underweight", value: "17 - 18.4", color: Colors.blue),
            Divider(),
            getWeightDetail(
                title: "Healthy weight",
                value: "18.5 - 24.9",
                color: Colors.green),
            Divider(),
            getWeightDetail(
                title: "Overweight", value: "25 - 29.9", color: Colors.orange),
            Divider(),
            getWeightDetail(
                title: "Obese class I",
                value: "30 - 34.9",
                color: Colors.redAccent),
            Divider(),
            getWeightDetail(
                title: "Obese class II", value: "35 - 39.9", color: Colors.red),
            Divider(),
            getWeightDetail(
                title: "Obese class III",
                value: ">=40",
                color: Colors.red.shade800),
            Divider(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              buildBmiInfoCard(),
              SizedBox(
                height: 18,
              ),
              buildPersonInfoCard(),
              SizedBox(
                height: 18,
              ),
              buildBmiInfoText(),
              SizedBox(
                height: 18,
              ),
              buildDetailTile(),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
