import 'package:flutter/material.dart';
import '../../../../../constants/constant.dart';
import '../../../../../pages/main/setting_page/faq_page.dart';

import '../write_us_page.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants _constants = Constants();

    buildDivider() {
      return Container(
        height: 1,
        color: Colors.blue.withOpacity(.1),
      );
    }

    buildCard(
        {required String title,
        required String subTitle,
        required IconData icon,
        required Function onTap}) {
      return ListTile(
        onTap: () => onTap(),
        leading: Icon(icon),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(subTitle),
      );
    }

    return Column(
      children: [
        buildDivider(),
        buildCard(
            title: "Quick help",
            subTitle: "View some frequently asked questions",
            icon: Icons.question_mark,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return FAQPage();
              }));
            }),
        buildDivider(),
        buildCard(
            title: "Write to Us",
            subTitle: "Average Response Time 24-48 Hrs",
            icon: Icons.edit_outlined,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return WriteUsPage();
              }));
            }),
        buildDivider(),
        buildCard(
            title: "Call Now",
            subTitle: "Call us to discuss your problem",
            icon: Icons.phone_outlined,
            onTap: () => _constants.openUrl(url: "tel: +91 ${9669395879}")),
        buildDivider(),
      ],
    );
  }
}
