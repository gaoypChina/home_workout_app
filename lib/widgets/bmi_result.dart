import 'package:flutter/material.dart';
class ResultScreen extends StatelessWidget {
  final bmiModel;

  ResultScreen({this.bmiModel});

  @override
  Widget build(BuildContext context) {
    Color themeColor = Colors.white;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.blue,
          width: double.infinity,
          height: 200,
          //   padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
                width: 200,
                child: bmiModel.isNormal
                    ? Image.asset(
                        "assets/bmi_faces/happy_face.png",
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/bmi_faces/sad_face.webp',
                        fit: BoxFit.contain,
                      ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Your BMI is ${bmiModel.bmi.round()}",
                style: TextStyle(
                    color: themeColor,
                    fontSize: 34,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "${bmiModel.comments}",
                style: TextStyle(
                    color: themeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              bmiModel.isNormal
                  ? Text(
                      "Hurray! Your BMI is Normal.",
                      style: TextStyle(
                          color: themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      "Sadly! Your BMI is not Normal.",
                      style: TextStyle(
                          color: themeColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  label: Text("LET CALCULATE AGAIN"),

                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
              )
            ],
          ),
        ));
  }
}
