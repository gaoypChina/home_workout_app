import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:full_workout/components/height_weightSelector.dart';
import 'package:full_workout/constants/constants.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/helper/weight_db_helper.dart';
import 'package:full_workout/models/weight_list_model.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../main.dart';

class WeightDetailTab1 extends StatefulWidget {
  @override
  _WeightDetailTab1State createState() => _WeightDetailTab1State();
}

class _WeightDetailTab1State extends State<WeightDetailTab1> {
  bool isLoading = true;
  var weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  Constants constants = Constants();
  List<WeightList> weight = [];
  bool isDateSelected = false;
  double weightValue;
  double lbsWeight;
  List<String> rangeTypeList = ['Week', 'Month', 'Custom'];
  String rangeType = "Month";
  double initWeight = 0.0;
  DateTime selectedMnth;
  String firstDate = "";
  String lastDate = "";

  loadWeightData() async {
    double value = await spHelper.loadDouble(spKey.weight) ?? 0;
    weightValue = value;
    lbsWeight = value * 2.20462 == null ? 0 : value * 2.20462;
  }

  _loadRangeData(DateTime startDate, DateTime endDate) async {
    weight = [];
    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day + 1);
    List items = await weightDb.getRangeData(parsedStartDate, parsedEndDate);
    for (int idx = 0; idx < items.length; idx++) {
      weight.add(
          WeightList(weightModel: WeightModel.map(items[idx]), index: idx));
    }
    setState(() {
      isLoading = false;
    });
  }

  _loadData() async {
    await loadWeightData();
    DateTime now = DateTime.now();
    await _loadRangeData(
        DateTime(now.year, now.month, 1).subtract(Duration(days: 1)),
        DateTime(now.year, now.month + 1, 1));

    firstDate = DateFormat.yMMMd().format(DateTime(now.year, now.month, 1));
    lastDate = DateFormat.yMMMd().format(
        DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)));

    setState(() {
      isLoading = false;
    });
  }

  onRangeChange(String value) async {
    setState(() {
      isLoading = true;
    });
    if (value == rangeTypeList[0]) {
      isLoading = true;
      _loadRangeData(
        DateTime.now().subtract(Duration(days: 7)),
        DateTime.now(),
      );
      firstDate =
          DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 7)));
      lastDate = DateFormat.yMMMd().format(DateTime.now());
    } else if (value == rangeTypeList[1]) {
      isLoading = true;
      DateTime selectedMonth =
          await showMonthPicker(context: context, initialDate: DateTime.now());
      if (selectedMonth == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      setState(() {
        firstDate = DateFormat.yMMMd().format(selectedMonth);
        lastDate = DateTime.now().month == selectedMonth.month
            ? DateFormat.yMMMd().format(DateTime.now())
            : DateFormat.yMMMd().format(
                DateTime(selectedMonth.year, selectedMonth.month + 1, 1)
                    .subtract(Duration(days: 1)));
        selectedMnth = DateTime(selectedMonth.year, selectedMonth.month, 1);
      });
      _loadRangeData(
          selectedMnth,
          DateTime(selectedMonth.year, selectedMonth.month + 1, 1)
              .subtract(Duration(days: 1)));
    } else if (value == rangeTypeList[2]) {
      DateTimeRange dateSelected = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2019, 01, 01),
          lastDate: DateTime.now());
      if (dateSelected == null) {
        setState(() {
          isLoading = false;
        });
      }
      _loadRangeData(
          DateTime(dateSelected.start.year, dateSelected.start.month,
              dateSelected.start.day),
          DateTime(dateSelected.end.year, dateSelected.end.month,
              dateSelected.end.day));
      setState(() {
        firstDate = DateFormat.yMMMd().format(dateSelected.start);
        lastDate = DateFormat.yMMMd().format(dateSelected.end);
      });
    }

    setState(() {
      rangeType = value;
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  getDetail(bool isDark) {
    print(weight.length.toString() + ": weight length");
    return isLoading ? Center(child: CircularProgressIndicator(),): (weight.length == 0)
        ? getEmptyList()
        : Column(children: [
            ...weight.map((item) {
              onDelete() async {
                var userRes = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        title: Text("Do you want to delete weight record?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text("Yes")),
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text("No")),
                        ],
                      );
                    });

                if (userRes == true) {
                  int res = await weightDb.deleteWeight(item.weightModel.key);
                  if (res == 1) {
                    weight.removeWhere((element) =>
                        element.weightModel.key == item.weightModel.key);
                    setState(() {});
                    constants.getToast("Weight Record deleted successfully");
                  }
                } else
                  return;
              }

              onEdit() async {
                double value = await showDialog(
                    context: context,
                    builder: (context) => WeightSelector(
                          weightIndex: 0,
                          weight: item.weightModel.weight,
                        ));

                DateTime selectedDate = DateTime.parse(item.weightModel.date);
                DateTime todayDate = DateTime.now();
                double toSave =
                    (value == null) ? item.weightModel.weight : value;
                if (selectedDate.day == todayDate.day &&
                    selectedDate.month == todayDate.month &&
                    selectedDate.year == todayDate.year) {
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
                }
                var currModel = item.weightModel;
                WeightModel weightModel =
                    WeightModel(currModel.date, toSave, currModel.key);
                await weightDb.addWeight(toSave, weightModel, currModel.key);
                if (value != null) {
                  weight.forEach((element) {
                    if (element.weightModel.key == currModel.key) {
                      weight.removeAt(element.index);
                      weight.insert(element.index,
                          WeightList(weightModel: weightModel, index: 0));
                      setState(() {});
                    }
                  });
                  constants.getToast("Weight update successfully");
                }
              }

              String formatedDay = DateFormat.yMMMd()
                  .format(DateTime.parse(item.weightModel.date));
              double wd = 0;
              if (item.index == weight.length - 1) {
                wd = 0;
              } else {
                wd = weight[item.index].weightModel.weight -
                    weight[item.index + 1].weightModel.weight;
              }
              return Column(
                children: [
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 0,
                  ),
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 14, bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatedDay,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    item.weightModel.weight.toStringAsFixed(2),
                                style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              TextSpan(
                                text: " Kg",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: isDark ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              wd.isNegative
                                  ? Icon(
                                      Icons.arrow_downward_sharp,
                                      color: Colors.red,
                                      size: 25,
                                    )
                                  : wd == 0
                                      ? Icon(Icons.compare_arrows,
                                          color: Colors.blue, size: 25)
                                      : Icon(Icons.arrow_upward_outlined,
                                          color: Colors.green, size: 25),
                              SizedBox(
                                width: wd.abs().toStringAsFixed(2).length >= 5
                                    ? 3
                                    : 10,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: wd.abs().toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontSize: 16),
                                ),
                                TextSpan(
                                  text: "Kg",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontSize: 14),
                                ),
                              ]))
                            ],
                          ),
                        ],
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => onDelete()),
                      IconSlideAction(
                          caption: 'Edit',
                          color: Colors.green,
                          icon: Icons.edit,
                          onTap: () => onEdit()),
                    ],
                  ),
                ],
              );
            }).toList(),
          ]);
  }

  getEmptyList() {
    return Column(
      children: [
        Container(
            child:
                Image.asset("assets/other/list2.png", fit: BoxFit.fitHeight)),
        Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Center(
              child: Positioned(
                  left: 20,
                  child: Text(
                    "No Record Found!",
                    style: textTheme.subtitle1.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  )),
            ),
          ],
        )
      ],
    );
  }

  getDateRange() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18, top: 12, bottom: 12),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstDate,
            style: textTheme.headline4.copyWith(
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.compare_arrows,
            size: 20,
          ),
          SizedBox(width: 20),
          Text(
            lastDate,
            style: textTheme.headline4.copyWith(fontSize: 16),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        padding: EdgeInsets.only(right: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: () async {
              double previousValue = weightValue;
              double value = await showDialog(
                  context: context,
                  builder: (context) =>
                      WeightSelector(weight: weightValue, weightIndex: 0));
              DateTime selectedDate = DateTime.now();
              double toSave = (value == null) ? previousValue : value;
              await spHelper.saveDouble(spKey.weight, toSave);
              String key = DateFormat.yMd().format(selectedDate).toString();
              WeightModel weightModel =
                  WeightModel(selectedDate.toIso8601String(), toSave, key);
              if (weightModel.weight == null) return;
              await weightDb.addWeight(toSave, weightModel, key);

              if (weight[0].weightModel.key == key) {
                weight.removeAt(0);
                weight.insert(
                    0, WeightList(index: 0, weightModel: weightModel));
              } else {
                weight.insert(
                    0, WeightList(index: 0, weightModel: weightModel));
              }
              setState(() {});
                 constants.getToast("Weight added successfully");
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              "Add weight",
              style:
                  textTheme.button.copyWith(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8, right: 16),
              child: Row(
                children: [
                  Text(
                    "Weight History",
                    style: textTheme.subtitle1
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Colors.blue,
                    ),
                    padding:
                        EdgeInsets.only(left: 8, right: 4, top: 6, bottom: 6),
                    child: DropdownButton<String>(
                        value: rangeType,
                        dropdownColor: Colors.blue,
                        focusColor: Colors.blue,
                        items: rangeTypeList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          );
                        }).toList(),
                        isDense: true,
                        elevation: 2,
                        underline: Container(
                          color: Colors.blue,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.white,
                        ),
                        hint: Text(
                          rangeType,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        onChanged: (String value) => onRangeChange(value)),
                  )
                ],
              ),
            ),
            getDateRange(),
            getDetail(isDark),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}