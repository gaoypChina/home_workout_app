import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../helper/weight_db_helper.dart';
import '../../../models/weight_list_model.dart';
import '../../../models/weight_model.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../detail_input_page/user_detail_widget/weight_picker.dart';

class WeightChart extends StatefulWidget {
  final Function onAdd;
  final bool showButton;
  final String title;

  WeightChart(
      {required this.onAdd, required this.title, required this.showButton});

  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  bool isLoading = true;
  DateTime currDate = DateTime.now();
  var weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  Constants constants = Constants();
  List<WeightList> weightDataList = [];
  List<FlSpot> dataList = [];
  double maxWeight = 0;
  double minWeight = 0;
  int tillDate = 30;
  DateTime initMonth = DateTime.now();
  late double? weightValue;
  late double? lbsWeight;

  loadWeightData() async {
    double value = await spHelper.loadDouble(spKey.weight) ?? 0;
    weightValue = value;
    lbsWeight = value * 2.20462;
  }

  _loadRangeData(DateTime startDate, DateTime endDate) async {
    setState(() {
      isLoading = true;
    });
    weightDataList = [];
    dataList = [];
    List<dynamic> minWeightDB = await weightDb.getMinWeight();

    minWeight =
        (minWeightDB[0]["MIN(weight)"] == null || minWeightDB.length == 0)
            ? 0
            : minWeightDB[0]["MIN(weight)"];

    List<dynamic> maxWeightDB = await weightDb.getMaxWeight();
    maxWeight =
        (maxWeightDB[0]["MAX(weight)"] == null || maxWeightDB.length == 0)
            ? 0
            : maxWeightDB[0]["MAX(weight)"];
    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day + 1);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day + 1);
    List items = await weightDb.getRangeData(parsedStartDate, parsedEndDate);
    for (int idx = 0; idx < items.length; idx++) {
      weightDataList.add(
          WeightList(weightModel: WeightModel.map(items[idx]), index: idx));
    }
    setState(() {
      isLoading = false;
    });
  }

  loadCurrentMonth(DateTime currMonth) async {
    DateTime now = DateTime.now();
    if (currMonth.year == now.year && currMonth.month == now.month) {
      tillDate = DateTime.now().day;
    } else {
      tillDate = 30;
    }
    initMonth = currMonth;
  }

  addWeight() async {
    double? value = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => WeightPicker(),
    );
    DateTime selectedDate = DateTime.now();
    if (value == null) {
      return;
    }

    await spHelper.saveDouble(spKey.weight, value);
    String key = DateFormat.yMd().format(selectedDate).toString();
    WeightModel weightModel = WeightModel(
      selectedDate.toIso8601String(),
      value,
      key,
      DateTime.now().millisecondsSinceEpoch,
    );

    await weightDb.addWeight(value, weightModel, key);
    widget.onAdd();

    constants.getToast(
      "Weight Added Successfully",
    );
    setState(() {});
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    await loadWeightData();
    await _loadRangeData(
        DateTime(DateTime.now().year, DateTime.now().month, 01),
        DateTime(DateTime.now().year, DateTime.now().month + 1, 01));
    await loadCurrentMonth(DateTime.now());
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
    double height = MediaQuery.of(context).size.height;

    return isLoading
        ? Container(
            height: height * .6,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 18.0, bottom: widget.showButton ? 0 : 18),
                    child: Text(
                      widget.title,
                      style: Constants().titleStyle,
                    ),
                  ),
                  Spacer(),
                  widget.showButton
                      ? TextButton(
                          onPressed: () async => addWeight(),
                          child: Icon(Icons.add))
                      : Container()
                ],
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 18, left: 10, bottom: 5, top: 5),
                height: height * .55,
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
                                backgroundColor: Colors.blue,
                                primary: Colors.white),
                            onPressed: () async {

                              final selectedMonth = await showMonthYearPicker(

                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2021),
                                lastDate: DateTime.now(),
                              );

                              if (selectedMonth == null) {
                                return;
                              }
                              await loadCurrentMonth(selectedMonth);
                              setState(() {
                                currDate = selectedMonth;
                                _loadRangeData(
                                    DateTime(selectedMonth.year,
                                        selectedMonth.month, 01),
                                    DateTime(selectedMonth.year,
                                        selectedMonth.month + 1, 01));
                              });
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
              ),
            ],
          );
  }

  LineChartData mainData() {
    List<Color> gradientColors = [
      Colors.blue.shade500,
      Colors.blue,
    ];

    double presentValue = 0;
    Color color = Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.7);

    if (weightDataList.length > 0) {
      presentValue =
          weightDataList[weightDataList.length - 1].weightModel.weight;
    }
    getData() {
      dataList = [];
      for (int i = 1; i <= tillDate; i++) {
        for (int j = 0; j < weightDataList.length; j++) {
          if (i == DateTime.parse(weightDataList[j].weightModel.date).day) {
            presentValue = weightDataList[j].weightModel.weight;
          }
        }
        dataList.add(FlSpot(i.toDouble(), presentValue));
      }
      return dataList;
    }

    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: true, touchTooltipData: LineTouchTooltipData()),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: color.withOpacity(.15),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: color.withOpacity(.15),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: 1,
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: (value, _) {
              if (value.toInt() % 2 == 0) {
                return Text(
                  (value.toInt()).toString(),
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w600, fontSize: 12),
                );
              }
              return Container();
            },
          )),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, _) {
                  return Text(value.toInt().toString(),
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 12));
                }),
          ),
          rightTitles: AxisTitles(),
          topTitles: AxisTitles()),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1.5)),
      minX: 1,
      maxX: 30,
      minY: weightDataList.length == 0 ? 0 : minWeight - 18,
      maxY: weightDataList.length == 0
          ? 50
          : maxWeight == 0
              ? 90
              : maxWeight + 18,
      lineBarsData: [
        LineChartBarData(
          spots: getData(),
          gradient: LinearGradient(colors: gradientColors),
          isCurved: true,
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
        ),
      ],
    );
  }
}
