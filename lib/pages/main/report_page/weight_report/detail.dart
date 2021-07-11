import 'package:flutter/material.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/pages/main/report_page/weight_report/weight_chart.dart';
import 'package:full_workout/widgets/height_weightSelector.dart';
import 'package:intl/intl.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
 bool isLoading = true;
  var weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  final List<WeightList> weight = [];


  double weightValue;
  double lbsWeight;

  _loadData() async {
    await spHelper.loadDouble(spKey.weight).then((value) {
      setState(() {
        weightValue = value;
        lbsWeight = value * 2.20462 == null ? 0 : value * 2.20462;
      });
    });
  }

  DateTime initDate = DateTime.now();
  double initWeight = 0.0;



  _readWeightData() async {
    print(weight.length);
    List items = await weightDb.getAllWeight();
    for(int idx =0; idx< items.length; idx ++){
      weight.add(WeightList(weightModel: WeightModel.map(items[idx]),index:idx));
    }
  }

  @override
  void initState() {

    _readWeightData();
    _loadData();
    setState(() {
      isLoading = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getDetail(){
      return Column(
        children: weight.map((item){
          String formatedDay = DateFormat.yMMMd().format(DateTime.parse(item.weightModel.date));
          double wd =0;
          if(item.index ==weight.length-1){
            wd =0;
          }else{
            wd =weight[item.index].weightModel.weight- weight[item.index+1].weightModel.weight ;
          }
          return
            Container(
              height: 80,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:CrossAxisAlignment.center ,
                    children: [
                      Text(formatedDay),
                      Text(item.weightModel.weight.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          wd.isNegative?Icon(Icons.arrow_downward_sharp,color: Colors.red,size: 30,):  Icon(Icons.arrow_upward_outlined,color: Colors.green,size: 30),
                          Text(wd.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
        }).toList(),
   //     children:weight.map((e) => Container(height: 200,child: Text( e.date.toString()))).toList() ,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Weight History"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          double previousValue = weightValue;
          double initVal = 0;
          for(int i =0; i<10; i++){
            DateTime selectedDate = DateTime.now();
            String key = DateFormat.yMd().format(selectedDate).toString();
            WeightModel weightModel =
            WeightModel(selectedDate.toIso8601String(), 60.1+i, i.toString());
            if (weightModel.weight == null) return;
            await weightDb.addWeight(60.0, weightModel, i.toString());
          }
          double value = await showDialog(
              context: context,
              builder: (context) => HeightWeightSelector(
                title: "Weight",
                label1: "kg",
                label2: "lbs",
                selected: 0,
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
          await weightDb.addWeight(toSave, weightModel, key);
          setState(() {
            weightValue = toSave;
            lbsWeight = toSave * 2.20462;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Detail()),
          );
          //  initState();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(


        child:  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20,),

                WeightChart(),
                SafeArea(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
Text("Date"),Text("weight"),Text("Loss/Gain")
                ],)),
                getDetail()
              ],
            ),
          ),

      ),
    );
  }
}

class WeightList{
 final WeightModel weightModel;
 final int index;

  WeightList({this.weightModel, this.index});
}
