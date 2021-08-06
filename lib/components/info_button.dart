

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String tooltip;

  InfoButton({this.icon, this.onPress, this.tooltip});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 8,bottom: 5),
      child: Container(
        height: 35,
        width: 35,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: onPress,
          child: Icon(icon,color:Colors.white,size: 22,),
          tooltip: tooltip,
        ),
      ),
    );
  }
}