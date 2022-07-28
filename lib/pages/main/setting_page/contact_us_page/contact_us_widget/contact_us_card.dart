import 'package:flutter/material.dart';
import 'package:full_workout/constants/constant.dart';

import '../write_us_page.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants _constants = Constants();

    buildCard(
        {required String title,
        required String subTitle,
        required IconData icon,
        required Function onTap}) {
      return ListTile(
        onTap: () => onTap(),
        leading: Icon(icon),
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
        _constants.getThinDivider(),
        buildCard(
            title: "Quick help",
            subTitle: "View some frequently asked questions",
            icon: Icons.question_mark,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return const WriteUsPage();
              }));
            }),
        _constants.getThinDivider(),

        buildCard(
            title: "Write to Us",
            subTitle: "Average Response Time 24-48 Hrs",
            icon: Icons.edit_outlined,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                return const WriteUsPage();
              }));
            }),
        _constants.getThinDivider(),
        buildCard(
            title: "Call Now",
            subTitle: "Call us to discuss your problem",
            icon: Icons.phone_outlined,
            onTap: () => _constants.openUrl(url: "tel: +91 ${9669395879}")),


        _constants.getThinDivider(),
      ],
    );
  }
}
