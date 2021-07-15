import 'package:flutter/material.dart';
import 'package:full_workout/helper/weight_db_helper.dart';

class WeightReportStatics extends StatefulWidget {
  @override
  _WeightReportStaticsState createState() => _WeightReportStaticsState();
}

class _WeightReportStaticsState extends State<WeightReportStatics> {
  bool isLoading = true;
  WeightDatabaseHelper _databaseHelper = WeightDatabaseHelper();
  String minWeight = "";
  String maxWeight = "";
  String currWeight = "";
  loadData() async {

  List<dynamic> minWeightDB = await  _databaseHelper.getMinWeight();
  print(minWeightDB);
  minWeight = minWeightDB.length == 0?"NaN": minWeightDB[0]["MIN(weight)"].toString();

  List<dynamic> maxWeightDB = await  _databaseHelper.getMaxWeight();
  print(maxWeightDB);
  maxWeight = maxWeightDB.length == 0?"NaN": maxWeightDB[0]["MAX(weight)"].toString();

  List<dynamic> currWeightDB = await _databaseHelper.getCurrWeight();
  print(currWeightDB);
  currWeight =minWeight.length==0 ?"NaN": currWeightDB[0]["weight"].toString();

  print(minWeight);
  print(maxWeight);
    print(currWeight);
  }

  @override
  void initState() {
    loadData();

    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getWeightDetail({String title, String value, Color color}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              size: 12.0,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(title),
            Spacer(),
            Text(value)
          ],
        ),
      );
    }

    return isLoading == true ? Center(child: CircularProgressIndicator()): Column(
      children: [
        getWeightDetail(
            title: "Current", value: currWeight, color: Colors.blue),
        getWeightDetail(
            title: "Heaviest", value: maxWeight, color: Colors.red),
        getWeightDetail(
            title: "Lightest", value: minWeight, color: Colors.green),
      ],
    );
  }
}
