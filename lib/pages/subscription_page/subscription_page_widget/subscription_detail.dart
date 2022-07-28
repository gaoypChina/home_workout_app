import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../provider/subscription_provider.dart';

class SubscriptionDetail extends StatefulWidget {
  const SubscriptionDetail({Key? key}) : super(key: key);

  @override
  State<SubscriptionDetail> createState() => _SubscriptionDetailState();
}

class _SubscriptionDetailState extends State<SubscriptionDetail> {
  getFormatedTime({required DateTime time}) {
    final DateFormat formatter = DateFormat.yMMMMd();
    return formatter.format(time);
  }

  double? getBarPercent(
      {required DateTime firstDate, required DateTime lastDate}) {
    int totalDay = lastDate.difference(firstDate).inSeconds;
    int remainingDay = lastDate.difference(DateTime.now()).inSeconds;
    try {
      if (totalDay == 0) {
        throw "error : divided by zero";
      }

      double per = (totalDay - remainingDay) / totalDay;
      return per > 1.0 ? 0.2 : per;
    } catch (e) {
      log("error : subscription percent loading error : $e ");
      return null;
    }
  }

  buildDetail({required title, required subtitle}) {
    return Row(children: [
      Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white.withOpacity(.9)),
      ),
      Spacer(),
      Text(
        subtitle.toString(),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white.withOpacity(.9)),
      ),
    ]);
  }

  buildItem({required SubscriptionProvider provider}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Home Workout Pro",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          if (provider.subscriptionDetail != null)
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * .86,
              barRadius: Radius.circular(18),
              lineHeight: 6.0,
              percent: getBarPercent(
                  firstDate: provider.subscriptionDetail!.firstDate,
                  lastDate: provider.subscriptionDetail!.lastDate) ?? 0.2,
              backgroundColor: Colors.white.withOpacity(.4),
              progressColor: Colors.white.withOpacity(.80),
            ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                "Valid till",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.9)),
              ),
              Spacer(),
              if (provider.subscriptionDetail != null)
                Text(
                  getFormatedTime(time: provider.subscriptionDetail!.lastDate),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white.withOpacity(.9)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  buildExpandedItem({required SubscriptionProvider provider}) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        buildDetail(
            title: "Purchased date",
            subtitle: provider.subscriptionDetail != null
                ? getFormatedTime(time: provider.subscriptionDetail!.firstDate)
                : "nan"),
        SizedBox(
          height: 4,
        ),
        buildDetail(
            title: "Amount Paid",
            subtitle: provider.subscriptionDetail?.price ?? 0),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SubscriptionProvider>(context);
    return InkWell(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColor.withOpacity(.9),
              border: Border.all(color: Colors.blue.withOpacity(.0), width: 2)),
          child: Column(
            children: [
              buildItem(provider: provider),
              buildExpandedItem(provider: provider),
            ],
          )),
    );
  }
}
