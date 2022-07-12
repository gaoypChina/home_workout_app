
import 'package:flutter/material.dart';

class DetailPageCustomWidget{

  static Color tileColor = Colors.blue.withOpacity(.1);
 static buildTitle({required String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 12,)
      ],
    );
  }
}