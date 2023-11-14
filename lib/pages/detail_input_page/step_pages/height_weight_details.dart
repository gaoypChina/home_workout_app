import 'package:flutter/material.dart';
import '../../../provider/user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../user_detail_widget/custom_detail_input.dart';
import '../user_detail_widget/detail_page_custom_widget.dart';
import '../user_detail_widget/height_picker.dart';
import '../user_detail_widget/user_detail_submit_button.dart';
import '../user_detail_widget/weight_picker.dart';

class HeightWeightDetails extends StatefulWidget {
  final Function onBack;
  final Function onNext;

  const HeightWeightDetails(
      {Key? key, required this.onNext, required this.onBack})
      : super(key: key);

  @override
  State<HeightWeightDetails> createState() => _HeightWeightDetailsState();
}

class _HeightWeightDetailsState extends State<HeightWeightDetails> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(context);

    return Scaffold(
      bottomNavigationBar: UserDetailSubmitButton(
          onTap: widget.onNext, isActive: provider.isStep2Completed),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
            ),
            DetailPageCustomWidget.buildTitle(
                title: "Select measurement unit", context: context),
            UnitSelector(),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 18,
            ),
            CustomDetailInput(
              onTap: () async {
                double? weight = await showModalBottomSheet(
                  context: context,
                  builder: (context) => WeightPicker(),
                );

                if (weight != null) provider.setWeight(weight);
              },
              hasData: provider.weight != null,
              title: "Select your weight",
              content: provider.getWeightString,
            ),
            SizedBox(
              height: 28,
            ),
            CustomDetailInput(
              hasData: provider.height != null,
              onTap: () async {
                double? height = await showModalBottomSheet(
                  context: context,
                  builder: (context) => HeightPicker(),
                );
                if (height != null) {
                  provider.setHeight(height);
                }
              },
              title: "Select your Height",
              content: provider.getHeightString,
            ),
          ],
        ),
      ),
    );
  }
}

class UnitSelector extends StatelessWidget {
  const UnitSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserDetailProvider>(context);
    _buildUnit(
        {required String title,
        required int index,
        required BorderRadius radius}) {
      bool isSelected = index == provider.unit;
      return InkWell(
        onTap: () {
          provider.switchUnit(index);
        },
        child: Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          decoration: BoxDecoration(
            border:
                Border.all(color: DetailPageCustomWidget.borderColor, width: 1),
            color: isSelected
                ? Theme.of(context).primaryColor
                : DetailPageCustomWidget.tileColor,
            borderRadius: radius,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(.7),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        _buildUnit(
            index: 0,
            title: "Cm/Kg",
            radius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
        _buildUnit(
            index: 1,
            title: "In/Lbs",
            radius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ],
    );
  }
}
