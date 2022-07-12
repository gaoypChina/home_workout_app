import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.withOpacity(.4),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.bouncingBall(
              color: Colors.blue.shade700,
              size: 100,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "All progress takes place outside the comfort zone. All progress takes place outside the comfort zone. ",
             textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.2,
              fontSize: 16,
              fontWeight: FontWeight.w500

              ),
            )
          ],
        ),
      ),
    );
  }
}
