import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, top: 4, bottom: 4, right: 6),
            child: Row(
              children: [
                Text(
                  "Select Theme",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                Spacer(),
                CloseButton(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ],
            ),
          ),
          Container(
            height: .8,
            color: Colors.grey.withOpacity(.2),
          ),
          SizedBox(
            height: 4,
          ),
          Consumer<ThemeProvider>(builder: (context, data, _) {
            _buildTile(
                {required String title,
                required IconData icon,
                required int index}) {
              bool isSelected = data.switchIndex == index;
              return InkWell(
                onTap: () {
                  data.setTheme(index: index, context: context);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 12, bottom: 14, top: 14),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color:
                            isSelected ? Theme.of(context).primaryColor : null,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : null,
                            fontSize: 15,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w400),
                      ),
                      Spacer(),
                      isSelected
                          ? Icon(
                              Icons.radio_button_checked_outlined,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(Icons.radio_button_off_outlined),
                      SizedBox(
                        width: 18,
                      )
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                _buildTile(
                    title: "Light", icon: FontAwesomeIcons.sun, index: 0),
                _buildTile(
                    title: "Dark", icon: FontAwesomeIcons.moon, index: 1),
                _buildTile(
                    title: "System", icon: FontAwesomeIcons.circle, index: 2),
              ],
            );
          }),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
