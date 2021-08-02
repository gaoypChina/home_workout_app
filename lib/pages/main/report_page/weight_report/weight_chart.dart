import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/models/weight_list_model.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class WeightChart extends StatefulWidget {

  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  bool isLoading = true;
  DateTime currDate = DateTime.now();
  WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();
  List<WeightList> weightDataList = [];
  List<FlSpot> dataList = [];
  double maxWeight = 0;
  double minWeight = 0;

  _loadRangeData(DateTime startDate, DateTime endDate) async {

    weightDataList = [];
    dataList = [];

    setState(() {
      isLoading = true;
    });
   // loadMinMax();
    List<dynamic> minWeightDB = await weightDatabaseHelper.getMinWeight();

    minWeight = minWeightDB.length == 0 ? 0 : minWeightDB[0]["MIN(weight)"];

    List<dynamic> maxWeightDB = await weightDatabaseHelper.getMaxWeight();
    print(maxWeightDB);
    maxWeight = maxWeightDB.length == 0 ? 0 : maxWeightDB[0]["MAX(weight)"];
    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day + 1);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day + 1);
    List items =
        await weightDatabaseHelper.getRangeData(parsedStartDate, parsedEndDate);
    for (int idx = 0; idx < items.length; idx++) {
      weightDataList.add(
          WeightList(weightModel: WeightModel.map(items[idx]), index: idx));
    }
    print(minWeight);
    setState(() {
      isLoading = false;
    });
  }

  loadMinMax() async {
    List<dynamic> minWeightDB = await weightDatabaseHelper.getMinWeight();

    minWeight = minWeightDB.length == 0 ? 0 : minWeightDB[0]["MIN(weight)"];

    List<dynamic> maxWeightDB = await weightDatabaseHelper.getMaxWeight();
    print(maxWeightDB);
    maxWeight = maxWeightDB.length == 0 ? 0 : maxWeightDB[0]["MAX(weight)"];

  }

  @override
  void initState() {

    _loadRangeData(DateTime(DateTime.now().year, DateTime.now().month, 01),
        DateTime(DateTime.now().year, DateTime.now().month + 1, 01));
    super.initState();
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return isLoading
        ? Container(
      height: height*.6,
          width: double.infinity,
          child: Center(
              child: CircularProgressIndicator(),
            ),
        )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: height*.55,
            child: Stack(
              children: [
                LineChart(
                  mainData(),
                ),
                Positioned(
                    right: 5,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.only(left: 4),
                            backgroundColor:
                                Colors.blue.shade700.withOpacity(.5),
                            primary: Color(0xff37434d)),
                        onPressed: () async {
                          DateTime selectedMonth = await showMonthPicker(
                              context: context, initialDate: DateTime.now());
                          if (selectedMonth == null) {
                            return;
                          }
                          setState(() {
                            currDate = selectedMonth;
                            _loadRangeData(
                                DateTime(selectedMonth.year,
                                    selectedMonth.month, 01),
                                DateTime(selectedMonth.year,
                                    selectedMonth.month + 1, 01));
                          });
                          print(currDate);
                        },
                        child: Row(
                          children: [
                            Text(DateFormat.yMMM().format(currDate)),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                          ],
                        )))
              ],
            ),
          );
  }

  LineChartData mainData() {
    double presentValue = 0;

    if (weightDataList.length > 0) {
      presentValue =
          weightDataList[weightDataList.length - 1].weightModel.weight;
    }
    getData() {
      dataList = [];
      for (int i = 1; i <= 30; i++) {

        for (int j = 0; j < weightDataList.length; j++) {
          if (i == DateTime
              .parse(weightDataList[j].weightModel.date)
              .day) {
            presentValue = weightDataList[j].weightModel.weight;
          }
        }
        dataList.add(FlSpot(i.toDouble(), presentValue));
      }
      return dataList;
    }


    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: .2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 0.2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles:
        SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.w600,
              fontSize: 12),
          getTitles: (value) {
            if (value.toInt() % 2 == 0) {
              return value.toInt().toString();
            }
            return '';
          },
          margin: 5,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            if (value.toInt() % 5 == 0) {
              return value.toInt().toString();
            }
            return '';
          },
          reservedSize: 16,
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1.5)),
      minX: 1,
      maxX: 30,
      minY: weightDataList.length == 0 ? 0:minWeight -20,
      maxY: weightDataList.length == 0 ? 50 :maxWeight +20,
      lineBarsData: [
        LineChartBarData(
          spots: getData(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
            gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

