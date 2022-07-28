import 'package:firebase_auth/firebase_auth.dart';
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
  void initState() {
    var data = Provider.of<UserDetailProvider>(context, listen: false);

    data.nameController = TextEditingController(
        text: FirebaseAuth.instance.currentUser?.displayName ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(
      context,
    );
    _buildName() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailPageCustomWidget.buildTitle(
              title: "What's your Name?", context: context),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: DetailPageCustomWidget.tileColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: DetailPageCustomWidget.borderColor, width: 1),
              ),
              child: TextField(
                controller: provider.nameController,
                onChanged: (String? name) {
                  provider.onNameSubmitted(input: name);
                },
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.8)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Colors.transparent,
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
                    border:
                        Border.all(color: DetailPageCustomWidget.borderColor),
                    color: provider.gender == index
                        ? Theme.of(context).primaryColor
                        : DetailPageCustomWidget.tileColor,
                    shape: BoxShape.circle),
                child: Icon(
                  icon,
                  color: provider.gender == index
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(.5),
                  size: 28,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.8)),
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
          DetailPageCustomWidget.buildTitle(
              title: "Select Gender", context: context),
          Row(
            children: [
              _buildGenderIcon(
                  icon: Icons.male_outlined, title: "Male", index: 0),
              Spacer(),
              _buildGenderIcon(
                  icon: Icons.female_outlined, title: "Female", index: 1),
              Spacer(),
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
                height: 28,
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
