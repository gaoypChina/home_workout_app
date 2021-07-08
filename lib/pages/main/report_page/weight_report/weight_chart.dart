import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class WeightChart extends StatefulWidget {
  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();

  List weightData;

  loadData(DateTime currDate) async {
    weightData = await weightDatabaseHelper.getRangeData(currDate);
    return weightData;
  }

  @override
  void initState() {
    print(weightData);
    //  loadData();
    print(weightData);
    super.initState();
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  DateTime currDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 350,
      child: Stack(
        children: [
          LineChart(
            mainData(),
          ),
          Positioned(
              right: 5,
              child: TextButton(

                  style: TextButton.styleFrom(padding: EdgeInsets.only(left: 4),
                      backgroundColor: Colors.blue.shade700.withOpacity(.5),
                      primary:Color(0xff37434d)),
                  onPressed: () async {
                    DateTime selectedMonth = await showMonthPicker(
                        context: context, initialDate: DateTime.now());
                    if (selectedMonth == null) {
                      return;
                    }
                    currDate = selectedMonth;
                    setState(() {});
                    print(selectedMonth);
                    List data = await loadData(selectedMonth);
                    print(data.toString());
                  },
                  child: Row(
                    children: [
                      Text(DateFormat.yMMM().format(currDate)),
                      SizedBox(width: 2,),
                      Icon(Icons.arrow_drop_down_rounded,),
                    ],
                  )))
        ],
      ),
    );
  }

  LineChartData mainData() {
    List<FlSpot> dataList = [];
    double currWeight = 60;

    List<FlSpot> getData() {
      for (int i = 1; i <= 30; i++) {
        for (int j = 0; j < 0; j++) {}
        if (i % 3 == 0) {
          dataList.add(FlSpot(i.toDouble(), currWeight - 3));
        } else {
          dataList.add(FlSpot(i.toDouble(), currWeight + i + 1));
        }
      }
      return dataList;
    }

    getData();
    return LineChartData(
      backgroundColor: Colors.white70,
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
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
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
      minY: 30,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 60),
            FlSpot(8, 40),
            FlSpot(13, 70),
            FlSpot(19, 60),
            FlSpot(30, 70)
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
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
