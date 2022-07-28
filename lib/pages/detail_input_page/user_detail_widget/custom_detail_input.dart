import 'package:flutter/material.dart';

import 'detail_page_custom_widget.dart';

class CustomDetailInput extends StatelessWidget {
  final title;
  final onTap;
  final content;
  final hasData;

  const CustomDetailInput(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.hasData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPageCustomWidget.buildTitle(title: title,context: context),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  content,
                  style: TextStyle(
                      fontSize: 16,
                      color: hasData
                          ? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8)
                          : Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.6),
                      fontWeight: hasData ? FontWeight.w400 : FontWeight.w400),
                ),
                Spacer(),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: DetailPageCustomWidget.borderColor),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: DetailPageCustomWidget.tileColor),
          ),
        )
      ],
    );
  }
}
