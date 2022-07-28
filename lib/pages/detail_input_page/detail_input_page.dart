import 'package:flutter/material.dart';
import 'package:full_workout/pages/detail_input_page/step_pages/basic_details.dart';
import 'package:full_workout/pages/detail_input_page/step_pages/body_type.dart';
import 'package:full_workout/pages/detail_input_page/step_pages/height_weight_details.dart';
import 'package:full_workout/pages/detail_input_page/step_pages/workout_prefrence.dart';
import 'package:full_workout/pages/detail_input_page/user_detail_widget/custom_loading_indicator.dart';
import 'package:full_workout/provider/user_detail_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/dialogs/exit_app_dialog.dart';

class DetailInputPage extends StatefulWidget {
  static const routeName = "detail-input-screen";

  const DetailInputPage({Key? key}) : super(key: key);

  @override
  _DetailInputPageState createState() => _DetailInputPageState();
}

class _DetailInputPageState extends State<DetailInputPage> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    void onNext() {
      if (currentStep >= 3) {
        Provider.of<UserDetailProvider>(context, listen: false)
            .saveData(context: context);
      } else {
        setState(() => currentStep++);
      }
    }

    onBack() async {
      if (currentStep == 0) {
        await exitAppDialog(context: context);
      } else {
        setState(() {
          currentStep--;
        });
      }
      return Future<bool>.value(false);
    }

    Widget currentStepWidget({required int index}) {
      if (index == 0) {
        return BasicDetails(
          onNext: onNext,
          onBack: onBack,
        );
      } else if (index == 1) {
        return HeightWeightDetails(
          onNext: onNext,
          onBack: onBack,
        );
      } else if (index == 2) {
        return WorkoutPreference(
          onNext: onNext,
          onBack: onBack,
        );
      } else if (index == 3) {
        return BodyType(
          onNext: onNext,
          onBack: onBack,
        );
      } else {
        return Container();
      }
    }

    List<String> appbarTitle = [
      "Basic Details",
      "Body Measurement",
      "Workout preference",
      "Body Type"
    ];

    return WillPopScope(
      onWillPop: () {
        return onBack();
      },
      child: Consumer<UserDetailProvider>(builder: (context, provider, _) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                automaticallyImplyLeading: currentStep != 0,
                leading: currentStep == 0
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          onBack();
                        },
                      ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Step ${currentStep + 1} of ${appbarTitle.length}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      appbarTitle[currentStep],
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: currentStepWidget(index: currentStep),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
