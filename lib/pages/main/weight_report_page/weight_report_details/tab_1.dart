import 'package:flutter/material.dart';
import '../../../../provider/weight_report_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../../../enums/weight_filter.dart';

class WeightDetailTab1 extends StatefulWidget {
  @override
  _WeightDetailTab1State createState() => _WeightDetailTab1State();
}

class _WeightDetailTab1State extends State<WeightDetailTab1> {
  var columnStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  @override
  void initState() {
    Provider.of<WeightReportProvider>(context, listen: false).initData();

    super.initState();
  }

  getBottomSheet({
    required BuildContext context,
    required String date,
    required String weight,
    required Function onEdit,
    required Function onDelete,
  }) {
    getButton(
        {required Icon icon, required String label, required Function onTap}) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(left: 18),
        ),
        onPressed: () async {
          bool res = await onTap();
          if (res == true) Navigator.of(context).pop();
        },
        child: Container(
          height: 50,
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 20,
              ),
              Text(label),
            ],
          ),
        ),
      );
    }

    return SlidingSheetDialog(
        cornerRadius: 16,
        snapSpec: SnapSpec(initialSnap: 1),
        builder: (context, state) {
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(left: 22),
                  title: Text(date),
                  subtitle: Text(weight + " Kg"),
                ),
                Divider(
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                getButton(icon: Icon(Icons.edit), label: "Edit", onTap: onEdit),
                getButton(
                    icon: Icon(Icons.delete), label: "Delete", onTap: onDelete),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }

  getVLine() {
    return Container(
      width: .4,
      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
    );
  }

  getVLineTitle() {
    return Container(
      height: double.infinity,
      width: .5,
      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
    );
  }

  getDetail() {
    var provider = Provider.of<WeightReportProvider>(context);
    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : (provider.weight.length == 0)
            ? getEmptyList()
            : Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: Column(children: [
                  Container(
                    height: 50,
                    //    color: Theme.of(context).cardColor,
                    child: Row(
                      children: [
                        getVLineTitle(),
                        Expanded(
                            child: Container(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          child:
                              Center(child: Text("Date", style: columnStyle)),
                        )),
                        getVLineTitle(),
                        Expanded(
                            child: Container(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          child:
                              Center(child: Text("Weight", style: columnStyle)),
                        )),
                        getVLineTitle(),
                        Expanded(
                            child: Container(
                          color: Theme.of(context).primaryColor.withOpacity(.1),
                          child: Center(
                              child: Text("Gain/Loss", style: columnStyle)),
                        )),
                        getVLineTitle(),
                      ],
                    ),
                  ),
                  Container(
                      height: .5,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5)),
                  ...provider.weight.map((item) {
                    // onDelete() async {
                    //   var userRes = await showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(16))),
                    //           title: Text("Do you want to delete weight record?"),
                    //           actions: [
                    //             TextButton(
                    //                 onPressed: () => Navigator.pop(context, true),
                    //                 child: Text("Yes")),
                    //             TextButton(
                    //                 onPressed: () =>
                    //                     Navigator.pop(context, false),
                    //                 child: Text("No")),
                    //           ],
                    //         );
                    //       });
                    //
                    //   if (userRes == true) {
                    //     await weightDb.deleteWeight(item.weightModel.key);
                    //     await _loadData();
                    //     constants.getToast("Weight Deleted Successfully");
                    //   }
                    //
                    //   Navigator.pop(context, false);
                    // }
                    //
                    // onEdit() async {
                    //   double? value = await showDialog(
                    //       context: context,
                    //       builder: (context) => WeightSelector(
                    //             weightIndex: 0,
                    //             weight: item.weightModel.weight,
                    //           ));
                    //
                    //   DateTime selectedDate =
                    //       DateTime.parse(item.weightModel.date);
                    //   DateTime todayDate = DateTime.now();
                    //   if (value == null) return;
                    //
                    //   if (selectedDate.day == todayDate.day &&
                    //       selectedDate.month == todayDate.month &&
                    //       selectedDate.year == todayDate.year) {
                    //     await spHelper.saveDouble(spKey.weight, value);
                    //     String key =
                    //         DateFormat.yMd().format(selectedDate).toString();
                    //     WeightModel weightModel = WeightModel(
                    //         selectedDate.toIso8601String(), value, key);
                    //     if (weightModel.weight == null) {
                    //       Navigator.pop(context, false);
                    //     }
                    //     await weightDb.addWeight(value, weightModel, key);
                    //
                    //     await _loadData();
                    //
                    //     setState(() {
                    //       weightValue = value;
                    //       lbsWeight = value * 2.20462;
                    //     });
                    //   }
                    //   Navigator.pop(context, true);
                    //
                    //   constants.getToast("Weight Updated Successfully");
                    // }

                    String formatedDay = DateFormat.yMMMd()
                        .format(DateTime.parse(item.weightModel.date));
                    double wd = 0;
                    if (item.index == provider.weight.length - 1) {
                      wd = 0;
                    } else if (provider.weight.length > 1) {
                      wd = provider.weight[item.index].weightModel.weight -
                          provider.weight[item.index + 1].weightModel.weight;
                    }
                    return Column(
                      children: [
                        InkWell(
                          onLongPress: () {
                            // showSlidingBottomSheet(context, builder: (context) {
                            //   return getBottomSheet(
                            //     context: context,
                            //     weight:
                            //         item.weightModel.weight.toStringAsFixed(2),
                            //     date: formatedDay,
                            //     onDelete: () {},
                            //     onEdit: () {},
                            //   );
                            // });
                          },
                          child: Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getVLine(),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      formatedDay,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                getVLine(),
                                Expanded(
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: item.weightModel.weight
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        TextSpan(
                                          text: " Kg",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                getVLine(),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              : Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: Colors.green,
                                                  size: 25),
                                      SizedBox(
                                        width: wd
                                                    .abs()
                                                    .toStringAsFixed(2)
                                                    .length >=
                                                5
                                            ? 3
                                            : 10,
                                      ),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                          text: wd.abs().toStringAsFixed(2),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: "Kg",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                              fontSize: 14),
                                        ),
                                      ])),
                                    ],
                                  ),
                                ),
                                getVLine(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: .5,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.5),
                        ),
                      ],
                    );
                  }).toList(),
                ]),
              );
  }

  getEmptyList() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
          ),
          Container(
            height: 100,
            child: Image.asset("assets/other/empty-box (1).png"),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "No Record Found!",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.color
                    ?.withOpacity(.7)),
          )
        ],
      ),
    );
  }

  getDateRange() {
    var provider = Provider.of<WeightReportProvider>(context);

    return Container(
        child: Row(
      children: [
        Text(
          provider.firstDate,
          style: TextStyle(
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
          provider.lastDate,
          style: TextStyle(fontSize: 16),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeightReportProvider>(context, listen: false);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
            color: Theme.of(context).primaryColor.withOpacity(.0),
            child: Row(
              children: [
                getDateRange(),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding:
                      EdgeInsets.only(left: 8, right: 4, top: 6, bottom: 6),
                  child: DropdownButton<String>(
                      value: provider.rangeType,
                      dropdownColor: Theme.of(context).primaryColor,
                      focusColor: Colors.blue,
                      items: provider.rangeTypeList
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
                        provider.rangeType,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        if (value == null) return;
                        provider.rangeType = value;
                        WeightFilter filter =
                            provider.setFilter(value.toLowerCase());
                        provider.onRangeChange(filter, context);
                      }),
                ),
              ],
            ),
          ),
          Container(
              height: .5,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(.5)),
          getDetail(),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
