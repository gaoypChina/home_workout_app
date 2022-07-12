import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectivityErrorDialog extends StatelessWidget {
  const ConnectivityErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 2.5)),
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.close,
          size: 36,
          color: Colors.red,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No Internet",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          SizedBox(
            height: 18,
          ),
          Text("Poor network connection detected. Please check your connectivity",textAlign: TextAlign.center,),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text("Try Again"),
          style: ElevatedButton.styleFrom(primary: Colors.red.shade400,minimumSize: Size(150,45)),)
        ],
      ),
    );
  }
}
