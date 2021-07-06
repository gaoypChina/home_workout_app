import 'package:flutter/material.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import '../../../main.dart';
import 'bmi_picker.dart';

class BmiCard extends StatefulWidget {
  @override
  _BmiCardState createState() => _BmiCardState();
}

class _BmiCardState extends State<BmiCard> {
  SpHelper _spHelper = new SpHelper();
  SpKey _spKey = new SpKey();

  bool _isLoading = true;

  double weight = 0;
  double height = 0;

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
    String remark = "";
    TextStyle titleStyle = textTheme.subtitle1
        .copyWith(fontWeight: FontWeight.w700);

    double _calcBmi(double height, double weight) {
      return weight / (height * height);
    }

    String _getRemark(double bmi) {
      String subtitle = "";
      if (bmi < 16) {
        subtitle = "Very severely Underweight ";
      } else if (bmi >= 16 && bmi <= 16.9) {
        subtitle = "Severely underweight";
      } else if (bmi >= 17 && bmi <= 18.4) {
        subtitle = "Underweight";
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        subtitle = "Healthy weight";
      } else if (bmi >= 25 && bmi <= 29.9) {
        subtitle = "Overweight";
      } else if (bmi >= 30 && bmi <= 34.9) {
        subtitle = "Obese class I";
      } else if (bmi >= 35 && bmi <= 39.9) {
        subtitle = "Obese class II";
      } else {
        subtitle = "Obese class III";
      }
      return subtitle;
    }

    if (height != null && weight != null) {
      bmi = double.parse(_calcBmi(height / 100, weight).toStringAsFixed(2));
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
        color: Colors.white,
        width: borderWidth,
      );
    }

    getBottomText(String text) {
      return Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      );
    }

    getMyHealth(String height, String weight){
      getDetail(String title, String value){
        return Column(
          children: [
            Text(title,style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),),
            SizedBox(height: 8,),
            Text(value,style: textTheme.headline2.copyWith(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.blue.shade800),),

          ],
        );
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "My Health",style: titleStyle,
                ),
                Spacer(),
                TextButton(onPressed: (){}, child: Text("EDIT"),style: TextButton.styleFrom(padding: EdgeInsets.all(0)),)
              ],
            ),
            Row(
              children: [
                Spacer(),
              getDetail("Height",height),
                Spacer(flex: 2,),
              getDetail("Weight",weight),
                Spacer(),
            ],)
          ],
        ),
      );
    }
    return (_isLoading)
        ? CircularProgressIndicator()
        : Column(
            children: [
              // TextButton(
              //     onPressed: () {
              //       showModalBottomSheet(
              //           context: context,
              //           builder: (builder) {
              //             return BottomSheet(
              //                 onClosing: () {},
              //                 builder: (builder) {
              //                   return Column(
              //                     children: [
              //                       getWeightDetail(
              //                           title: "Very Severely Underweight",
              //                           value: "<= 16",
              //                           color: Colors.blue),
              //                       getWeightDetail(
              //                           title: "Severely Underweight",
              //                           value: "16 - 16.9",
              //                           color: Colors.red),
              //                       getWeightDetail(
              //                           title: "Underweight",
              //                           value: "17 - 18.4",
              //                           color: Colors.green),
              //                       getWeightDetail(
              //                           title: "Healthy weight",
              //                           value: "18.5 - 24.9",
              //                           color: Colors.blue),
              //                       getWeightDetail(
              //                           title: "Overweight",
              //                           value: "25 - 29.9",
              //                           color: Colors.red),
              //                       getWeightDetail(
              //                           title: "Obese class I",
              //                           value: "30 - 34.9",
              //                           color: Colors.green),
              //                       getWeightDetail(
              //                           title: "Obese class II",
              //                           value: "35 - 39.9",
              //                           color: Colors.green),
              //                       getWeightDetail(
              //                           title: "Obese class III",
              //                           value: ">=40",
              //                           color: Colors.green),
              //                     ],
              //                   );
              //                 });
              //           });
              //     },
              //     child: Text(
              //       "More",
              //       style: textTheme.button,
              //     )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      "BMI(Kg/m^2) : $bmi",
                      style: titleStyle
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () async {
                          var res = await showDialog(
                              context: context,
                              builder: (context) {
                                return BMIPicker();
                              });
                          setState(() {
                            _spHelper.saveDouble(_spKey.height, res[0]);
                            _spHelper.saveDouble(_spKey.weight, res[1]);
                            height = res[0];
                            weight = res[1];
                          });
                        },
                        child: Text("Edit")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: (bmi >= 15 && bmi <= 40)
                    ? Row(
                        children: [
                          SizedBox(width: (bmi - 15) * oneUnit),
                          Text(
                            bmi.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    : Container(),
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                height: 90,
                child: Stack(
                  children: [
                    Column(
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
                    (bmi >= 15 && bmi <= 40)
                        ? Row(
                            children: [
                              SizedBox(width: (bmi - 15) * oneUnit + 4),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 22,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      height: 10,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      height: 10,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      height: 10,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      height: 10,
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              Text(remark),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ),

              getMyHealth(height.toInt().toString() +" Cm",weight.toInt().toString()+" Kg"),
              SizedBox(height: 20,)
            ],
          );
  }
}
