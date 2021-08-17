import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushUpLevelDialog extends StatelessWidget {
  final int index;
  PushUpLevelDialog({@required this.index});

  @override
  Widget build(BuildContext context) {
    List<PushUpLevelItem> item = [
      PushUpLevelItem(title: "Beginner", subTitle: "3-5", index: 0),
      PushUpLevelItem(title: "Intermediate", subTitle: "5-10", index: 1),
      PushUpLevelItem(title: "Advanced", subTitle: "At lease 10", index: 2),
    ];

    getTitle() {
      return Column(
        children: [
          SizedBox(
            height: 18,
          ),
          ...item.map((item) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color:item.index==index?Colors.blue.withOpacity(.8): Colors.blue.withOpacity(.4),
              ),
              width: MediaQuery.of(context).size.width * .8,
              // padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.only(bottom: 18, left: 18, right: 18),
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12))),
                onPressed: () {
                  Navigator.pop(context,item.index);
                },
                child: Column(
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      item.subTitle,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          image: DecorationImage(
            image: AssetImage(
              "assets/other/backgroudnd_2.jpg",
            ),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black87.withOpacity(.3), BlendMode.color),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                CloseButton(
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 18, right: 18),
              child: Text(
                "How many push-pus can hou do at one time?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            getTitle(),
            SizedBox(height: 28,)
          ],
        ),
      ),
    );
  }
}

class PushUpLevelItem {
  String title;
  String subTitle;
  int index;

  PushUpLevelItem({this.title, this.subTitle, this.index});
}
