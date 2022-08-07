import 'package:flutter/material.dart';

import 'contact_us_widget/contact_us_card.dart';
import 'contact_us_widget/contact_us_header.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        title: Text(
          "Contact Us",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [const ContactUsHeader(), const ContactUsCard()],
        ),
      ),
    );
  }
}
