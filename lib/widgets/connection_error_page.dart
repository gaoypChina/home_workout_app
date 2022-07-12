
import 'package:flutter/material.dart';

class ConnectionErrorPage extends StatelessWidget {
  static const routeName = "connection-error-page";

  const ConnectionErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No internet connection......."),
      ),
    );
  }
}
