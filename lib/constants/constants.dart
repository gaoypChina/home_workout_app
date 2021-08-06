import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class Constants{





  Color bottomNavigationColor =  Color(0xffF2F2F2);
  Color darkSecondary = Colors.blueGrey.shade800;
  Color lightSecondary = Colors.blue.shade50;
  Color primaryColor = Colors.blue.shade700;


  TextStyle titleStyle =   textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700);

  var textStyle =textTheme.subtitle1.copyWith(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xffA9A9A9));
  var listTileTitleStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 17);
  Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 16,);


  getDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 8,
        width: double.infinity,
        color:isDark? Colors.grey.shade800:Colors.grey.shade200,
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