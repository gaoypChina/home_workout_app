import 'package:flutter/material.dart';

class PrimeIcon extends StatelessWidget {
  const PrimeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amberAccent.withOpacity(.6), shape: BoxShape.circle),
      padding: EdgeInsets.all(6),
      child: Image.asset(
        "assets/other/prime_icon.png",
        height: 18,
        color: Colors.white,
      ),
    );
  }
}
