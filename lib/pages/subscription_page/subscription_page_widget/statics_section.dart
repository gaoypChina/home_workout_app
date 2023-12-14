import 'package:flutter/material.dart';

class StaticsSection extends StatelessWidget {
  const StaticsSection({Key? key}) : super(key: key);

  buildCard({required title, required subtitle}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            SizedBox(height: 16,),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Text(subtitle),
            SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }

  buildDivider() {
    return Container(

      width: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28,horizontal: 16),
      child: Row(
        children: [
          buildCard(title: "1000+ ", subtitle: "5 Star Rating"),
          buildDivider(),
          buildCard(title: "200000+ ", subtitle: "Active Users"),
          buildDivider(),
          buildCard(title: "100000+ ", subtitle: "Seen Result"),
        ],
      ),
    );
  }
}
