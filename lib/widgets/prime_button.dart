import 'package:flutter/material.dart';

class PrimeButton extends StatelessWidget {
  const PrimeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 10, right: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              elevation: 1,
              padding: EdgeInsets.only(left: 12, right: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)))),
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/other/prime_icon.png",
                height: 18,
                color: Colors.amber.withOpacity(.98),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                "PRO",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )),
    );
  }
}
