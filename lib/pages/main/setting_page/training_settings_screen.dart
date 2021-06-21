import 'package:flutter/material.dart';
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
  @override
  void initState() {
    loadData();
    super.initState();
  }
  loadData()async{
    await spHelper.loadDouble(spKey.trainingRest).then((value) {
      setState(() {
        trainingRest= (value ==null)? 30.0:value;
      });
    });
    await spHelper.loadDouble(spKey.countdownTime).then((value){
      setState(() {
        countdownTime = (value ==null)?30.0:value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: 18,fontWeight: FontWeight.w800);
    var trailingStyle = TextStyle(fontSize: 16,fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: Text("Training Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Card(
            color: Colors.purple.withOpacity(.5),
            child: Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Training Rest",style: titleStyle,),
                    trailing: Container(
                      color:Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(trainingRest.toInt().toString()+" sec",style: trailingStyle,),
                        )),
                  ),
                  Slider(
                    value: trainingRest,
                    onChanged: (value)async{
                      setState(() {
                        trainingRest = value;
                      });
                      await spHelper.saveDouble(spKey.trainingRest, value);
                    },
                  max: 180,
                    min: 10,
                    label: trainingRest.toInt().toString(),
                    divisions: 34,
                    inactiveColor: Colors.white,
                    activeColor: Colors.purple,
                  ),
                  Divider(thickness: 2,),

                  ListTile(
                    title: Text("Countdown Time",style: titleStyle,),
                    trailing: Container(
                        color:Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(countdownTime.toInt().toString()+ " sec",style: trailingStyle,),
                        )),
                  ),
                  Slider(
                    value: countdownTime,
                    onChanged: (value)async{
                      setState(() {
                        countdownTime = value;
                      });
                      await spHelper.saveDouble(spKey.countdownTime, value);
                    },
                    max: 120,
                    min: 10,
                    label: countdownTime.toInt().toString(),
                    divisions: 22,
                    inactiveColor: Colors.white,
                    activeColor: Colors.purple,
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
