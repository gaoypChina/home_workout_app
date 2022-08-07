import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../helper/weight_db_helper.dart';
import '../../../models/weight_list_model.dart';
import '../../../models/weight_model.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../enums/weight_filter.dart';
import '../pages/detail_input_page/user_detail_widget/weight_picker.dart';

class WeightReportProvider with ChangeNotifier {
  bool isLoading = true;
  WeightDatabaseHelper _weightDb = WeightDatabaseHelper();
  SpHelper _spHelper = SpHelper();
  Constants _constants = Constants();
  SpKey _spKey = SpKey();
  List<WeightList> weight = [];
  late double weightValue;
  late double lbsWeight;
  WeightFilter filter = WeightFilter.month;
  double initWeight = 0.0;
  late DateTime selectedMnth;
  String firstDate = "";
  String lastDate = "";
  List<String> rangeTypeList = ['Week', 'Month', 'Custom'];
  String rangeType = "Month";

  WeightFilter setFilter(String value) {
    if (value == "month") return WeightFilter.month;
    if (value == "week")
      return WeightFilter.week;
    else
      return WeightFilter.custom;
  }

  addWeight({required BuildContext context}) async {
    double? value = await showMaterialModalBottomSheet(
      context: context,
      builder: (context) => WeightPicker(),
    );
    DateTime selectedDate = DateTime.now();
    if (value == null) return;
    await _spHelper.saveDouble(_spKey.weight, value);
    String key = DateFormat.yMd().format(selectedDate).toString();
    WeightModel weightModel = WeightModel(
      selectedDate.toIso8601String(),
      value,
      key,
      DateTime.now().millisecondsSinceEpoch,
    );
    await _weightDb.addWeight(value, weightModel, key);
    initData();
    _constants.getToast(
      "Weight Added Successfully",
    );
  }

  loadWeightData() async {
    double value = await _spHelper.loadDouble(_spKey.weight) ?? 0;
    weightValue = value;
    lbsWeight = value * 2.20462;
  }

  _loadRangeData(DateTime startDate, DateTime endDate) async {
    weight = [];
    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day + 1);
    List items = await _weightDb.getRangeData(parsedStartDate, parsedEndDate);

    for (int idx = 0; idx < items.length; idx++) {
      weight.add(
          WeightList(weightModel: WeightModel.map(items[idx]), index: idx));
    }

    isLoading = false;
    notifyListeners();
  }

  initData() async {
    await loadWeightData();
    DateTime now = DateTime.now();
    await _loadRangeData(
        DateTime(now.year, now.month, 1).subtract(Duration(days: 1)),
        DateTime(now.year, now.month + 1, 1));

    firstDate = DateFormat.yMMMd().format(DateTime(now.year, now.month, 1));
    lastDate = DateFormat.yMMMd().format(
        DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)));

    isLoading = false;
    notifyListeners();
  }

  onRangeChange(WeightFilter filter, BuildContext context) async {
    if (filter == WeightFilter.week) {
      isLoading = true;
      notifyListeners();
      _loadRangeData(
        DateTime.now().subtract(Duration(days: 7)),
        DateTime.now(),
      );
      firstDate =
          DateFormat.yMMMd().format(DateTime.now().subtract(Duration(days: 7)));
      lastDate = DateFormat.yMMMd().format(DateTime.now());
    } else if (filter == WeightFilter.month) {
      isLoading = true;
      DateTime? selectedMonth = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
      );
      if (selectedMonth == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      firstDate = DateFormat.yMMMd().format(selectedMonth);
      lastDate = DateTime.now().month == selectedMonth.month
          ? DateFormat.yMMMd().format(DateTime.now())
          : DateFormat.yMMMd().format(
              DateTime(selectedMonth.year, selectedMonth.month + 1, 1)
                  .subtract(Duration(days: 1)));
      selectedMnth = DateTime(selectedMonth.year, selectedMonth.month, 1);
      _loadRangeData(
          selectedMnth,
          DateTime(selectedMonth.year, selectedMonth.month + 1, 1)
              .subtract(Duration(days: 1)));

      isLoading = false;
      notifyListeners();
    } else if (filter == WeightFilter.custom) {
      DateTimeRange? dateSelected = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2019, 01, 01),
          lastDate: DateTime.now());
      if (dateSelected == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      _loadRangeData(
          DateTime(dateSelected.start.year, dateSelected.start.month,
              dateSelected.start.day),
          DateTime(dateSelected.end.year, dateSelected.end.month,
              dateSelected.end.day));

      firstDate = DateFormat.yMMMd().format(dateSelected.start);
      lastDate = DateFormat.yMMMd().format(dateSelected.end);
    }

    isLoading = false;
    notifyListeners();
  }
}
