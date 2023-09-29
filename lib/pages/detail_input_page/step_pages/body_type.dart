import 'package:flutter/material.dart';
import '../user_detail_widget/user_detail_submit_button.dart';

class BodyType extends StatefulWidget {
  final Function onBack;
  final Function onNext;

  const BodyType({Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  State<BodyType> createState() => _BodyTypeState();
}

class _BodyTypeState extends State<BodyType> {
  int selectedIdx = 3;

  @override
  Widget build(BuildContext context) {
    List<BodyTypeModel> bodyTypes = [
      BodyTypeModel(
          title: "Beginner",
          icon: Icons.star_border_outlined,
          subtitle: "I can do less than 10 Push Ups and 20 Squats.",
          color: Colors.green),
      BodyTypeModel(
          title: "Intermediate",
          icon: Icons.star_border_outlined,
          subtitle: "I can do more than 10 Push Ups and 20 Squats.",
          color: Colors.orange),
      BodyTypeModel(
          title: "Advance",
          icon: Icons.star_border_outlined,
          subtitle: "I can do more than 50 Push Ups and 100 Squats.",
          color: Colors.red),
    ];

    _buildCard({required BodyTypeModel bodyType}) {
      int idx = bodyTypes.indexOf(bodyType);
      bool isSelected = selectedIdx == idx;

      return Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(.5)
                    : bodyType.color.withOpacity(.2),
                width: 3)),
        child: ListTile(
          minLeadingWidth: 16,
          minVerticalPadding: 12,
          onTap: () {
            setState(() {
              selectedIdx = idx;
            });
          },
          title: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              bodyType.title,
              style: TextStyle(
                color: isSelected ? Colors.white : bodyType.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          subtitle: Text(
            bodyType.subtitle,
            style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.8),
                letterSpacing: 1.2,
                fontSize: 15),
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar:
          UserDetailSubmitButton(onTap: widget.onNext, isActive: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            ...bodyTypes
                .map((bodyType) => _buildCard(bodyType: bodyType))
                .toList()
          ],
        ),
      ),
    );
  }
}

class BodyTypeModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  BodyTypeModel(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.color});
}
