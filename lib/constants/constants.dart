import 'package:flutter/material.dart';

import '../main.dart';

class Constants{
  static Color primaryColor = Colors.blue;
  static Color secondaryTextColor = Colors.grey;





  Color titleBgColor = Color(0xffF6F6F6);
  Color titleColor = Color(0xffA9A9A9);
  Color tileColor =Color(0xffF2F2F2);
  Color leadingIconColor = Color(0xff969696);

  var textStyle =textTheme.subtitle1.copyWith(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xffA9A9A9));
  var contentTextStyle = textTheme.subtitle2.copyWith(fontSize: 15);
  Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,);

}