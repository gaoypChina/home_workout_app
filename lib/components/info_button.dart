import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String tooltip;
  final Color bgColor;
  final Color fgColor;

  const InfoButton(
      {super.key, required this.icon,
        required this.onPress,
        required this.tooltip,
        required this.bgColor,
        required this.fgColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: bgColor,
        foregroundColor: fgColor,
      ),

      onPressed: () => onPress(),
      child: Icon(
        icon,
        size: 22,
        color: fgColor,
      ),
      //  tooltip: tooltip,
    );
  }
}
