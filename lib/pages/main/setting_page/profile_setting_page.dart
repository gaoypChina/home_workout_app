import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../provider/user_detail_provider.dart';
import '../../detail_input_page/step_pages/height_weight_details.dart';
import '../../detail_input_page/user_detail_widget/custom_detail_input.dart';
import '../../detail_input_page/user_detail_widget/detail_page_custom_widget.dart';
import '../../detail_input_page/user_detail_widget/height_picker.dart';
import '../../detail_input_page/user_detail_widget/weight_picker.dart';

class ProfileSettingPage extends StatefulWidget {
  static const routeName = "profile-settings-page";

  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  bool isEditOn = true;
  bool isLoading = false;

  @override
  void initState() {
    Provider.of<UserDetailProvider>(context, listen: false).getLocalData();
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
              title: isEditOn ? "Enter your name" : "Name", context: context),
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
                        .bodyLarge!
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
                      : Theme.of(context).primaryColor.withOpacity(.6),
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
          DetailPageCustomWidget.buildTitle(
              title: "Select Gender", context: context),
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
      bottomNavigationBar: isEditOn
          ? Container(
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 8, top: 8),
              height: 60,
              width: double.infinity,
              color: Theme.of(context).bottomAppBarTheme.color,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await   provider.saveLocalData();
                  await   provider.getLocalData();
                  await Future.delayed(Duration(seconds: 1));

                  Constants().getToast("Profile updated successfully");
                  Navigator.of(context).pop();
                },
                child: isLoading
                    ? Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ))
                    : Text("Save".toUpperCase()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
              ),
            )
          : null,
      appBar: AppBar(
        title: Text("Profile"),
        actions: isEditOn
            ? null
            : [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isEditOn = true;
                    });
                  },
                  icon: Icon(Icons.edit_outlined),
                  label: Text("Edit Profile".toUpperCase()),
                ),
                SizedBox(
                  width: 8,
                )
              ],
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AbsorbPointer(
            absorbing: !isEditOn,
            child: Column(
              children: [
//             Container(
//               color: Colors.blue,
//               height:size.height*.28,
// width: size.width,
//               child: Stack(
//                 children: [
//                   Opacity(
//                     opacity:.6,
//                     child: Image.asset(
//                       "assets/explore_image/img_9.jpg",
//                       fit: BoxFit.fill,
//                       width: size.width,
//                       height:size.height*.28,
//
//                     ),
//                   ),
//                   Container(
//                     color: Colors.black.withOpacity(.2),
//
//                   ),
//
//
//
//
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white, shape: BoxShape.circle),
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 "AL",
//                                 style: TextStyle(
//                                     color: Colors.blueGrey,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 24),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 18,
//                             ),
//                             Text(
//                               "Akash Lilhare",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   letterSpacing: 1.2,
//                                   fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         ),
//
//                         Row(
//                           children: [
//                             _buildExercise(title: "Exercise", subtitle: "25"),
//                             _buildExercise(title: "Minute", subtitle: "06"),
//                             _buildExercise(title: "Calories", subtitle: "95")
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
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
                        title: isEditOn ? "Select DOB" : "DOB",
                        content: provider.dob == null
                            ? "Select your DOB"
                            : DateFormat.yMMMd().format(provider.dob!),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      DetailPageCustomWidget.buildTitle(
                          title: "Measurement Unit", context: context),
                      UnitSelector(),
                      SizedBox(
                        height: 28,
                      ),
                      CustomDetailInput(
                        onTap: () async {
                          double? weight = await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => WeightPicker(),
                          );

                          if (weight != null) provider.setWeight(weight);
                        },
                        hasData: provider.weight != null,
                        title: isEditOn ? "Select your weight" : "Weight",
                        content: provider.getWeightString,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      CustomDetailInput(
                        hasData: provider.height != null,
                        onTap: () async {
                          double? height = await showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => HeightPicker(),
                          );
                          if (height != null) {
                            provider.setHeight(height);
                          }
                        },
                        title: isEditOn ? "Select your Height" : "Height",
                        content: provider.getHeightString,
                      ),
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
