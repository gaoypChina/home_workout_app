import 'package:flutter/material.dart';

class StaticsSection extends StatelessWidget {
  const StaticsSection({Key? key}) : super(key: key);

  buildCard({required title, required subtitle}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          Text(subtitle)
        ],
      ),
    );
  }

  buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.green.withOpacity(.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 28),
      color: Colors.blue.withOpacity(.1),
      child: Row(
        children: [
          buildCard(title: "300+ ", subtitle: "5 Star Rating"),
          buildDivider(),
          buildCard(title: "50000+ ", subtitle: "Active User"),
          buildDivider(),
          buildCard(title: "10000+ ", subtitle: "User Seen result"),
        ],
      ),
    );
  }
}
