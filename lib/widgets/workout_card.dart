import 'package:flutter/material.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/pages/main/training_page/training_page.dart';

class WorkOutCard extends StatelessWidget {
  final String title;
  final String image;
  final String tag;
  final Function press;

  const WorkOutCard({
    @required this.tag,
    @required this.title,
    @required this.image,
    @required this.press,
  });

  @override
  Widget build(BuildContext context) {
    getPage(String id) {
      List<WorkoutList> list = [];
      if (id == "Abs Beginner") {
        return absBeginner;
      } else if (id == "Abs Intermediate") {
        return absIntermediate;
      } else if (id == "Abs Advance") {
        return absAdvance;
      } else if (id == "Chest Beginner") {
        return chestBeginner;
      } else if (id == "Chest Intermediate") {
        return chestIntermediate;
      } else if (id == "Chest Advance") {
        return chestAdvance;
      } else if (id == "Shoulder Beginner") {
        return shoulderBeginner;
      } else if (id == "Shoulder Intermediate") {
        return shoulderIntermediate;
      } else if (id == "Shoulder Advance") {
        return shoulderAdvance;
      } else if (id == "Legs Beginner") {
        return legsBeginner;
      } else if (id == "Legs Intermediate") {
        return legsIntermediate;
      } else if (id == "Legs Advance") {
        return legsAdvance;
      } else if (id == "Arms Beginner") {
        return armsBeginner;
      } else if (id == "Arms Intermediate") {
        return armsIntermediate;
      } else if (id == "Arms Advance") {
        return armsAdvance;
      } else {
        return list;
      }
    }
    List<String> type = ["Beginner", "Intermediate", "Advance"];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: Text(title),
        ),
        Container(
          height: 250,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  //colorFilter: ColorFilter.linearToSrgbGamma()
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                print(" $title ${type[index]} ");
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        " $title ${type[index]}",style: TextStyle(backgroundColor: Colors.black),
                        //   style: titleStyle,
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        child: Row(
                          children: [Icon(Icons.star)],
                        ),
                      ),
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainingPage( workOutList: getPage("$title ${type[index]}"),)));
                      },
                      subtitle: Container(
                        width: 50,
                        height: 30,
                        child: Row(children: [
                          Text("12 Exercise",style: TextStyle(backgroundColor: Colors.black),),
                          SizedBox(
                            width: 10,
                          ),
                          Text("25 Minute"),
                        ]),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white,
                );
              },
              itemCount: type.length),
        ),
      ],
    );
  }
}


