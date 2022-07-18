import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/models/product_wrapper.dart';


class Constants{

  String packageName = "com.akashlilhare.homeworkout";

  String playStoreLink ="https://bit.ly/playstore-homeworkout";
  //"https://play.google.com/store/apps/details?id=com.akashlilhare.homeworkout";

  // ToDo: Update version number

  String versionNumber ="1.7.6";


  TextStyle titleStyle =   TextStyle(fontWeight: FontWeight.w500,fontSize: 16,letterSpacing: 1.2);

  var textStyle =TextStyle(wordSpacing:4,fontWeight: FontWeight.w700,fontSize: 18,color: Color(0xffA9A9A9));
  var listTileTitleStyle = TextStyle(fontWeight: FontWeight.w500,fontSize: 16);
  Icon trailingIcon = Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 16,);


  getDivider({required BuildContext context}) {
    return Container(
      color: Colors.grey.withOpacity(.2),
      height: 14,
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

  getSnackBar({required BuildContext context, required String msg}){
    final snackBar = SnackBar(content: Text(msg));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  String getPerMonthPrice( {required Product product}){
    String currencySymbol = product.priceString[0];
    double price = product.price;
    int duration =int.parse( product.description.split(" ")[0]);

    return "$currencySymbol${(price/duration).ceil()}";
}



}