import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class Constants{


   Color primaryColor = Color(0xff4278DF);



  Color appBarColor =Colors.white;
  Color appBarContentColor = Colors.black;
  Color bottomNavigationColor =  Color(0xffF2F2F2);
  Color titleBgColor = Color(0xffF6F6F6);
  Color titleColor = Color(0xffA9A9A9);
  Color tileColor =Colors.blue.shade50;//Color(0xffF2F2F2);
  Color leadingIconColor = Color(0xff969696);
  Color widgetColor = Color(0xff4278DF);

  var textStyle =textTheme.subtitle1.copyWith(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xffA9A9A9));
  var contentTextStyle = textTheme.subtitle2.copyWith(fontSize: 15);
  Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.black,size: 16,);


  getDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 8,
        width: double.infinity,
        color: Colors.grey.shade300,
      ),
    );
  }

  getToast(String message){
   return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}