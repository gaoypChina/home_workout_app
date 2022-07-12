import 'package:flutter/material.dart';

class UserDetailSubmitButton extends StatelessWidget {
  final Function onTap;
  final bool isActive;

  const UserDetailSubmitButton(
      {Key? key, required this.onTap, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 12),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: !isActive ? null : () => onTap(),
        child: Text("Continue".toUpperCase()),
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
      ),
    );
  }
}
