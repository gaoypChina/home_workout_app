import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_workout/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Select Theme",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,letterSpacing: 1.2),
          ),
          SizedBox(height: 20,),
          Consumer<ThemeProvider>(builder: (context, data, _) {
            return ToggleSwitch(
              initialLabelIndex: data.switchIndex,
              totalSwitches: 3,
              minWidth: 70,
              radiusStyle: true,
              cornerRadius: 10,
              inactiveBgColor: Theme.of(context).primaryColor.withOpacity(.1),
              // icons: const [
              //   FontAwesomeIcons.sun,
              //   FontAwesomeIcons.moon,
              //   FontAwesomeIcons.circle
              // ],
              labels: const ['Light', 'Dark', 'Auto'],
              onToggle: (index) {
                data.setTheme(index: index!, context: context);
                Navigator.of(context).pop();
              },
            );
          }),
          SizedBox(height: 10,),
        ],
      ),

    );
  }
}
