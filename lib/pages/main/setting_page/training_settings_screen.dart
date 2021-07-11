import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';

class TrainingSettingsScreen extends StatefulWidget {
  static const routeName = "training-settings-screen";

  @override
  _TrainingSettingsScreenState createState() => _TrainingSettingsScreenState();
}

class _TrainingSettingsScreenState extends State<TrainingSettingsScreen> {
  double trainingRest = 10;
  double countdownTime = 10;
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  Constants constants = Constants();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await spHelper.loadDouble(spKey.trainingRest).then((value) {
      setState(() {
        trainingRest = (value == null) ? 30.0 : value;
      });
    });
    await spHelper.loadDouble(spKey.countdownTime).then((value) {
      setState(() {
        countdownTime = (value == null) ? 30.0 : value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Training Settings",
          style: TextStyle(color: Colors.black),
        ),
        leading: TextButton(
          child: Icon(
            Icons.keyboard_backspace_sharp,
            color: Colors.black,
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Material(elevation: 1,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.timer,color: Colors.black,),
                  minLeadingWidth: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  tileColor: constants.tileColor,
                  title: Text(
                    "Training Rest",
                    style: constants.contentTextStyle.copyWith(fontSize: 18),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.all(
                           Radius.circular(12),
                           )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trainingRest.toInt().toString() + " Sec",
                          style:constants.contentTextStyle.copyWith(color: Colors.white),
                        ),
                      )),
                ),
              ),
              Material(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                elevation: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: constants.tileColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),

                  child: Slider(
                    value: trainingRest,
                    onChanged: (value) async {
                      setState(() {
                        trainingRest = value;
                      });
                      await spHelper.saveDouble(spKey.trainingRest, value);
                    },
                    max: 180,
                    min: 10,
                    inactiveColor: Colors.white,
                    label: trainingRest.toInt().toString(),
                    divisions: 34,
                    activeColor: Colors.blue.shade700,
                  ),
                ),
              ),
              Container(
                height: 10,
              ),


              Material(
                elevation: 1, borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)),
                child: ListTile(leading: Icon(Icons.timer,color: Colors.black,),
                  minLeadingWidth: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  tileColor: constants.tileColor,
                  title: Text(
                    "Countdown Time",
                     style: constants.contentTextStyle.copyWith(fontSize: 18),

    ),
                  trailing: Container(

                      decoration: BoxDecoration(
                          color: Colors.blue.shade700,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          countdownTime.toInt().toString() + " sec",
                          style: constants.contentTextStyle.copyWith(color: Colors.white),
                        ),
                      )),
                ),
              ),
              Material(
                elevation: 1,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                child: Container(
                  decoration: BoxDecoration(
                      color: constants.tileColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Slider(
                    value: countdownTime,
                    onChanged: (value) async {
                      setState(() {
                        countdownTime = value;
                      });
                      await spHelper.saveDouble(spKey.countdownTime, value);
                    },
                    max: 180,
                    min: 10,
                    label: countdownTime.toInt().toString(),
                    divisions: 22,
                    activeColor: Colors.blue.shade700,
                    inactiveColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
