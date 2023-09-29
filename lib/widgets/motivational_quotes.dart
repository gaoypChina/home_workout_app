import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/quotes_model.dart';

class MotivationalQuotes extends StatelessWidget {
  const MotivationalQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int idx = random.nextInt(100);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Icon(Icons.format_quote),
          SizedBox(
            height: 10,
          ),
          Text(
            quotesList[idx].quote,
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            height: 1,
            width: 20,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "- " + quotesList[idx].author,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.7) ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
