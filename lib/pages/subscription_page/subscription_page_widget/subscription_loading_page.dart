import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionLoadingPage extends StatelessWidget {
  const SubscriptionLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var baseColors = Colors.blue.withOpacity(.5);
    var highlightColor = Colors.grey.shade100;
    var bgColor = Colors.blue.withOpacity(.5);
    var width = MediaQuery.of(context).size.width;

    buildShape({required double height, required double width}) {
      return Shimmer.fromColors(
          baseColor: baseColors,
          highlightColor: highlightColor,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: bgColor),
            height: height,
            width: width,
          ));
    }

    buildListCard() {
      return ListTile(
        leading: Shimmer.fromColors(
            baseColor: baseColors,
            highlightColor: highlightColor,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildShape(
              height: 18,
              width: width * .7,
            ),
            SizedBox(
              height: 8,
            ),
            buildShape(
              height: 12,
              width: width * .5,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            SizedBox(
              width: 18,
            ),
            Expanded(child: buildShape(height: 48, width: 10)),
            SizedBox(
              width: 18,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildShape(
              height: 14,
              width: 200,
            ),
            SizedBox(
              height: 4,
            ),
            buildShape(
              height: 12,
              width: 120,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            buildListCard(),
            SizedBox(
              height: 18,
            ),
            buildListCard(),
            SizedBox(
              height: 18,
            ),
            buildListCard(),
            SizedBox(
              height: 18,
            ),
            buildListCard(),
            SizedBox(
              height: 18,
            ),
            buildListCard(),
            SizedBox(
              height: 18,
            ),
            buildListCard(),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 190,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    buildShape(height: 180, width: width * .35),
                    SizedBox(
                      width: 18,
                    ),
                    buildShape(height: 180, width: width * .35),
                    SizedBox(
                      width: 18,
                    ),
                    buildShape(height: 180, width: width * .35),
                    SizedBox(
                      width: 18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            buildShape(height: 200, width: width * .9),
            SizedBox(
              height: 68,
            ),
          ],
        ),
      ),
    );
  }
}
