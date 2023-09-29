import 'package:flutter/material.dart';

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Us",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Please get in touch and we will be happy to help you",
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(.7)),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18),
              child: Image.asset(
                "assets/other/contact_us.png",
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
