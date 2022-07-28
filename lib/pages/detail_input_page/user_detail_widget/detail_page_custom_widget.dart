
import 'package:flutter/material.dart';

class DetailPageCustomWidget{

  static Color tileColor = Colors.blue.withOpacity(.1);
  static Color borderColor = Colors.blue.withOpacity(.5);
 static buildTitle({required String title, required BuildContext context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.9)),),
        SizedBox(height: 12,)
      ],
    );
  }
}