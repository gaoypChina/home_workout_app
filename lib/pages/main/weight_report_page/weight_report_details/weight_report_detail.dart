import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_1.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_details/tab_2.dart';
import 'package:full_workout/provider/weight_report_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WeightReportDetail extends StatefulWidget {
  final Function onBack;
  final int index;

  WeightReportDetail({required this.onBack, required this.index});

  static const routeName = "weight-report-detail";

  @override
  State<WeightReportDetail> createState() => _WeightReportDetailState();
}

class _WeightReportDetailState extends State<WeightReportDetail> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeightReportProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: pageIdx == 0?FloatingActionButton.extended(

        onPressed: () async {
          provider.addWeight(context: context);
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        label: Text(
          "Add weight",
          style: TextStyle(fontSize: 16, color: Colors.white),
          textAlign: TextAlign.end,
        ),
      ):null,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text("Weight Tracker"),
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(bottom: 12),
            width: size.width,
            child: Center(
              child: ToggleSwitch(
                initialLabelIndex: pageIdx,
                totalSwitches: 2,
                minWidth: size.width / 2.2,
                minHeight: 45,
                dividerColor: Colors.white,
                fontSize: 18,
                cornerRadius: 2,
                iconSize: 20,
                inactiveBgColor: Theme.of(context).primaryColor.withOpacity(.1),
                icons: const [Icons.history, Icons.bar_chart],
                labels: const ['History', 'Statics'],
                onToggle: (index) {
                  setState(() {
                    pageIdx = index ?? 0;
                  });
                },
              ),
            ),

          ),
        ),
      ),
      body: PageView(
          scrollDirection: Axis.horizontal,onPageChanged: (int? index){

            setState(() {
              if(index != null)
              pageIdx = index;
            });
      },
        children: [ WeightDetailTab1() ,WeightDetailTab2()],
      ),
    );
  }
}
