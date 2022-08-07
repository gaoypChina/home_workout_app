import 'package:flutter/material.dart';

class SubscriptionErrorDialog extends StatelessWidget {
  const SubscriptionErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Purchase Error"),
      content: Text(
          "If your money detected and not able to enjoy prim feature then you can menage your subscription from subscription settings page or you can contact us."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close")),
      ],
    );
  }
}
