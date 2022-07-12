

import 'package:flutter/material.dart';

class DeleteAccountFailDialog extends StatelessWidget {
  const DeleteAccountFailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Account delete fail"),
      content: Text("To delete your data completely please try again."),
      actions: [TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Retry"))],
    );
  }
}
