import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final String? msg;
  final bool? isLoginPage;

  const CustomLoadingIndicator({Key? key,  this.msg, this.isLoginPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now();
    return WillPopScope(
      onWillPop: ()async{
        log(startTime.difference(DateTime.now()).inSeconds.toString());
        if(DateTime.now().difference(startTime).inSeconds >= 5){

          return true;
        }else{
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.5),
        body: AlertDialog(
          backgroundColor:  isLoginPage == null?null: Colors.blueGrey.shade900,
        content: Row(
             // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(

                  height: 50,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                  ),
                ),
             if(msg!=null)   Text(
                  msg!,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16,color: isLoginPage == null?null: Colors.white70),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
