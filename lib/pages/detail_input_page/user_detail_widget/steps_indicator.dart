import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator(
      {Key? key, required this.currentStep, required this.totalSteps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (int i = 0; i < totalSteps; i++)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                    color: currentStep >= i
                        ? Theme.of(context).primaryColor
                        : Colors.blue.withOpacity(.4),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
              ),
            ))
        ],
      ),
    );
  }
}
