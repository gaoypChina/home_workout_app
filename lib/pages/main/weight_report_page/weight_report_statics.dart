import 'package:flutter/material.dart';
import 'package:full_workout/helper/weight_db_helper.dart';

class WeightReportStatics extends StatefulWidget {
  @override
  _WeightReportStaticsState createState() => _WeightReportStaticsState();
}

class _WeightReportStaticsState extends State<WeightReportStatics> {
  WeightDatabaseHelper _databaseHelper = WeightDatabaseHelper();
  String minWeight = "";
  String maxWeight = "";
  String currWeight = "";
  bool isLoading = true;

  loadData() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> minWeightDB = await _databaseHelper.getMinWeight();
    print(minWeightDB);
    minWeight = minWeightDB[0]["MIN(weight)"] == null
        ? "NaN"
        : minWeightDB[0]["MIN(weight)"].toString();

    List<dynamic> maxWeightDB = await _databaseHelper.getMaxWeight();
    print(maxWeightDB);
    maxWeight = maxWeightDB[0]["MAX(weight)"] == null
        ? "NaN"
        : maxWeightDB[0]["MAX(weight)"].toString();

    List<dynamic> currWeightDB = await _databaseHelper.getCurrWeight();
    print(currWeightDB.toString() + "error");
    currWeight = currWeightDB.length ==0
        ? "NaN"
        : currWeightDB[0]["weight"].toString();

    print(minWeight);
    print(maxWeight);
    print(currWeight);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
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
              size: 14.0,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(title),
            Spacer(),
            isLoading?CircularProgressIndicator():
           value == "NaN" ? Text(value):Text(value +" Kg")
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
