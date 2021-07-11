
import 'package:flutter/material.dart';
import 'package:full_workout/database/weight_db_helper.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/models/weight_model.dart';
import 'package:full_workout/widgets/height_weightSelector.dart';
import 'package:intl/intl.dart';


class WeightReportDetail extends StatefulWidget {
  static const routeName = "health-report";

  @override
  _WeightReportDetailState createState() => _WeightReportDetailState();
}

class _WeightReportDetailState extends State<WeightReportDetail>
    with SingleTickerProviderStateMixin {
  var weightDb = WeightDatabaseHelper();
  SpHelper spHelper = SpHelper();
  SpKey spKey = SpKey();
  final List<WeightModel> weight = [];

  ScrollController _scrollController;
  TabController tabContoller;

  double weightValue;
  double lbsWeight;

  @override
  void initState() {
    _scrollController = new ScrollController();
    tabContoller = new TabController(
      vsync: this,
      length: 1,
    );
    _readWeightData();
    //_getChatData();
    _loadData();
    super.initState();
  }

  _readWeightData() async {
    print(weight.length);
    List items = await weightDb.getAllWeight();
    items.forEach((element) {
      setState(() {
        weight.add(WeightModel.map(element));
      });
    });
    print(weight.length);
  }

  // List<DataPoint<dynamic>> dateList = [];
  //
  // List<DataPoint<dynamic>> _getChatData() {
  //   for (int i = weight.length - 1; i >= 0; i--) {
  //     print(i);
  //     dateList.add(DataPoint<DateTime>(
  //         value: weight[i].weight, xAxis: DateTime.parse(weight[i].date)));
  //   }
  //   return dateList;
  // }

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

  @override
  Widget build(BuildContext context) {
    setState(() {
      initDate = DateTime.parse(weight[0].date) == null
          ? DateTime.now()
          : DateTime.parse(weight[0].date);
      initWeight = weight[0].weight == null ? 0.0 : weight[0].weight;
    });

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            double previousValue = weightValue;
            double initVal = 0;
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
            print(await weightDb.addWeight(toSave, weightModel, key));
            setState(() {
              weightValue = toSave;
              lbsWeight = toSave * 2.20462;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WeightReportDetail()),
            );
            //  initState();
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: Expanded(
                          child: Text(
                        "Weight History",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 22),
                        textAlign: TextAlign.start,
                        textScaleFactor: 1,
                      )),
                      //collapsedHeight: 55,
                      titleSpacing: 010,
                      backgroundColor: Colors.blue,
                      automaticallyImplyLeading: false,
                      expandedHeight: 290.0,
                      pinned: true,
                      floating: false,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(children: <Widget>[
                          // Container(
                          //   child: ChartWidget(
                          //     fromDate: initDate,
                          //     initWeight: initWeight,
                          //     dateList: dateList,
                          //     weight: weight,
                          //   ),
                          // ),
                        ]),
                      ),
                    ),
                  ];
                },
            body: TabBarView(
              controller: tabContoller,
              children:<Widget> [
                CustomScrollView(
                 slivers: [
                   SliverList(
                     delegate: SliverChildBuilderDelegate(
                         (context, index){
                           return Container(
                             height: (MediaQuery.of(context).size.height / .35),
                             child:
                             ListView.builder(itemCount: weight.length, itemBuilder: (BuildContext context,int index){
                               String formatedDay = DateFormat.yMMMd().format(DateTime.parse(weight[index].date));
                               double wd =0;
                               if(index ==weight.length-1){
                                 wd =0;
                               }else{
                                 wd =weight[index].weight- weight[index+1].weight ;
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
                                           Text(weight[index].weight.toString()),
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
                             }),
                           );
                         }
                     ),
                   )
                   // Expanded(
                   //   //  height: 80,
                   //   child: Card(
                   //     child: Padding(
                   //       padding: const EdgeInsets.all(18.0),
                   //       child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   //         children: [
                   //           Text("Date"),
                   //           Text("Weight"),
                   //           Text("Gain/Loss")
                   //         ],),
                   //     ),
                   //   ),
                   // ),
                   //
                   // SizedBox(height: 100,)
                 ],
               )
              ],
            ),
            ))
        // SingleChildScrollView(
        //   child: SafeArea(
        //     child:Column(
        //       children: [
        //         Container(
        //           child: ChartWidget( fromDate: initDate,initWeight: initWeight,dateList: dateList,weight: weight,),
        //         ),
        //         Container(
        //           height: 80,
        //           child: Card(
        //             child: Padding(
        //               padding: const EdgeInsets.all(18.0),
        //               child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                 Text("Date"),
        //                   Text("Weight"),
        //                   Text("Gain/Loss")
        //               ],),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: (MediaQuery.of(context).size.height / .35),
        //           child: ListView.builder(itemCount: weight.length, itemBuilder: (BuildContext context,int index){
        //             String formatedDay = DateFormat.yMMMd().format(DateTime.parse(weight[index].date));
        //             double wd =0;
        //             if(index ==weight.length-1){
        //               wd =0;
        //             }else{
        //               wd =weight[index].weight- weight[index+1].weight ;
        //             }
        //             return
        //                 Container(
        //                   height: 80,
        //                   child: Card(
        //                     child: Padding(
        //                       padding: const EdgeInsets.all(18.0),
        //                       child: Row(
        //                         mainAxisAlignment:MainAxisAlignment.spaceBetween,
        //                         crossAxisAlignment:CrossAxisAlignment.center ,
        //                         children: [
        //                           Text(formatedDay),
        //                           Text(weight[index].weight.toString()),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                             children: [
        //                             wd.isNegative?Icon(Icons.arrow_downward_sharp,color: Colors.red,size: 30,):  Icon(Icons.arrow_upward_outlined,color: Colors.green,size: 30),
        //                               Text(wd.toString()),
        //                             ],
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 );
        //           }),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
