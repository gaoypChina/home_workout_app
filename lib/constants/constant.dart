import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Constants{

  String packageName = "com.akashlilhare.homeworkout";

  String playStoreLink ="https://bit.ly/playstore-homeworkout";
  //"https://play.google.com/store/apps/details?id=com.akashlilhare.homeworkout";

  // ToDo: Update version number

  String versionNumber ="1.6.2";

  Color bottomNavigationColor =  Color(0xffF2F2F2);
  Color darkSecondary = Colors.blueGrey.shade800;
  Color lightSecondary = Colors.blue.shade50;
  Color primaryColor = Colors.blue.shade700;


  TextStyle titleStyle =   TextStyle(fontWeight: FontWeight.w500,fontSize: 16,letterSpacing: 1.2);

  var textStyle =TextStyle(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xffA9A9A9));
  var listTileTitleStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 16);
  Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 16,);


  getDivider({required BuildContext context}) {
    return  Container(
        height: 16,
        width: double.infinity,
        color:Theme.of(context).dividerColor,
    );
  }

  getThinDivider(){
    return  Container(
        height: .5,
        width: double.infinity,
        color:Colors.grey.shade300.withOpacity(.5),
    );
  }

  getToast(String message){
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,

        //    textColor: Colors.white,
        fontSize: 16.0
    );
  }

  String getPrice({required int price}) {
    String parsedCurrency = "₹$price";
    String parsedPrice = parsedCurrency.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return parsedPrice;
  }

}