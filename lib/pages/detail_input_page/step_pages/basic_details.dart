import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_detail_provider.dart';
import '../user_detail_widget/custom_detail_input.dart';
import '../user_detail_widget/detail_page_custom_widget.dart';
import '../user_detail_widget/user_detail_submit_button.dart';

class BasicDetails extends StatefulWidget {
  final Function onBack;
  final Function onNext;

  const BasicDetails({Key? key, required this.onBack, required this.onNext})
      : super(key: key);

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(
      context,
    );
    _buildName() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPageCustomWidget.buildTitle(title: "What's your Name?"),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    color: Colors.blue.withOpacity(provider.name != null? 1 : .5),width: 1.5),
              ),
              child: TextField(
                controller: provider.nameController,
                onChanged: (String? name) {
                  provider.onNameSubmitted(input: name);
                },
                style: TextStyle(
                  fontWeight:provider.name == null? FontWeight.w400: FontWeight.w500,
                  color: Theme.of(context).primaryColor
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: DetailPageCustomWidget.tileColor,
                  hintText: "Enter your name",

                ),
              ),
            ),
          ),
        ],
      );
    }

    _buildGenderIcon(
        {required IconData icon, required String title, required int index}) {
      return Expanded(
        child: InkWell(
          onTap: () {
            provider.switchGender(index: index);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(.1)),
                    color: provider.gender == index
                        ? Theme.of(context).primaryColor
                        : DetailPageCustomWidget.tileColor,
                    shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: provider.gender == index
                      ? Colors.white
                      : Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                  size: 28,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      );
    }

    _buildGender() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPageCustomWidget.buildTitle(title: "Select Gender"),
          Row(
            children: [
              _buildGenderIcon(
                  icon: Icons.male_outlined, title: "Male", index: 0),
              _buildGenderIcon(
                  icon: Icons.female_outlined, title: "Female", index: 1),
              _buildGenderIcon(
                  icon: Icons.adjust_outlined, title: "Other", index: 2),
            ],
          )
        ],
      );
    }

    return Scaffold(

      bottomNavigationBar: UserDetailSubmitButton(
          onTap: widget.onNext, isActive: provider.isStep1Completed),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              _buildGender(),
              SizedBox(
                height: 38,
              ),
              _buildName(),
              SizedBox(
                height: 28,
              ),
              CustomDetailInput(
                hasData: provider.dob != null,
                onTap: () {
                  provider.pickDOB(context: context);
                },
                title: "Select DOB",
                content: provider.dob == null
                    ? "Select your DOB"
                    : DateFormat.yMMMd().format(provider.dob!),
              ),
            ],
          )),
    );
  }
}
