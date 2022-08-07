import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../../constants/constant.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../workout_page/report_page.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _controller = TextEditingController();
    onSend() async {
      if (_controller.text.length < 3) {
        Constants().getToast("Enter valid message");
        return;
      }

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo info = await deviceInfo.androidInfo;

      String toSend =
          "version: ${info.version.release.toString()}, brand: ${info.brand.toString()}, display : ${size.height.toInt()}x${size.width.toInt()}\n\n";

      final Email email = Email(
        body: toSend + "\n" + _controller.text,
        subject: 'Home Workout Feedback',
        recipients: ['workoutfeedback@gmail.com'],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(email);
      } catch (e) {
        constants.getToast(
          "Not able to send email",
        );
      }
    }

    buildSendBtn() {
      return Container(
        color: Theme.of(context).cardColor,
        height: 70,
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 12, top: 12),
        width: size.width,
        child: ElevatedButton(
          onPressed: () {
            onSend();
          },
          child: Text("Send Feedback".toUpperCase()),
        ),
      );
    }

    buildTerms() {
      return RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "If you love our app please give us a ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme.of(context).textTheme.headline1!.color)),
          WidgetSpan(
              child: InkWell(
            onTap: () async {
              if (!await launch(Constants().playStoreLink))
                throw 'Could not launch ${Constants().playStoreLink}';
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("5",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color: Theme.of(context).primaryColor)),
                Icon(Icons.star_outline,
                    size: 18, color: Theme.of(context).primaryColor),
                Text("Rating",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 1.5,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          )),
          TextSpan(
              text: " on play store and ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme.of(context).textTheme.headline1!.color)),
          WidgetSpan(
              child: InkWell(
            onTap: () async {
              final String text =
                  "I\'m training with Home Workout and am getting great results. \n\nHere are workouts for every muscle group to achieve your fitness goal. no equipment is needed. \n\nDownload the app : ${constants.playStoreLink}";

              await Share.share(
                text,
              );
            },
            child: Text(" Refer",
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor)),
          )),
          TextSpan(
              text: " your friends",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: Theme.of(context).textTheme.headline1!.color)),
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Send Feedback"),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Do let us know how we are doing",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 18,
                ),
                TextField(
                    controller: _controller,
                    maxLines: 6,
                    decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        filled: true,
                        labelText: "Feedback",
                        contentPadding: EdgeInsets.all(12))),
                SizedBox(
                  height: 12,
                ),
                buildTerms(),
              ],
            ),
          ),
          buildSendBtn()
        ],
      ),
    );
  }
}
