import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart';

import '../../../../constants/constant.dart';



class WriteUsPage extends StatelessWidget {
   WriteUsPage({Key? key}) : super(key: key);

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    onSend() async{

      if(_controller.text.length < 3){
        Constants().getToast("Enter valid message");
        return ;
      }


      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo info = await deviceInfo.androidInfo;

      String toSend =
          "version: ${info.version.release.toString()}, brand: ${info.brand.toString()}, display : ${size.height.toInt()}x${size.width.toInt()}\n\n";

      final Email email = Email(
        body:"\n"+ _controller.text + "\n\n\n--------------------------------------------------------------\n" + toSend,
        subject: 'Home Workout Feedback',
        recipients: ['workoutfeedback@gmail.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (e) {
        Constants().getToast("Not able to send email",);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: Text(
          "Write to us",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Write Your Query",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Message",
                  border: OutlineInputBorder(),
                  label: Text("Query")),
            ),
            const Spacer(),
            ElevatedButton(
              child: Text("SUBMIT"),
              onPressed: ()  {
                onSend();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)),
            )
          ],
        ),
      ),
    );
  }
}

