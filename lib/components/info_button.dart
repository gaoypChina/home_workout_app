

import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String tooltip;

  InfoButton({required this.icon, required this.onPress, required this.tooltip});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: Colors.blue,
        onPrimary: Colors.black,
      ),

      onPressed:()=> onPress(),
      child: Icon(icon,color:Colors.white,size: 22,),
    //  tooltip: tooltip,
    );
}
}