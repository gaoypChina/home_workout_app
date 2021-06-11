import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:full_workout/database/workoutlist.dart';
import 'package:full_workout/helper/light_dark_mode.dart';
import '../pages/training_page/exercise_list_page.dart';

class WorkOutCard extends StatelessWidget {
  final String title;
  final String image;

  const WorkOutCard({
    @required this.title,
    @required this.image,
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
          padding: const EdgeInsets.only(left: 28.0,top: 16,bottom: 8),
          child: Text(title,style: textTheme.headline2.copyWith(fontSize: 18,fontWeight: FontWeight.w800),),
        ),
        Container(
          height: 250,
          margin: EdgeInsets.symmetric(horizontal: 16),
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
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        "$title ${type[index]}",
                        style: textTheme.bodyText1.copyWith(color: Colors.white,fontSize: 17),
                        //   style: titleStyle,
                      ),
                      trailing: Container(

                        width: 50,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection:Axis.horizontal,
                          itemCount: index+1,
                          itemBuilder: (context,index){
                            return  Row(
                              children: [
                                Icon(Icons.flash_on,color: Colors.white,size: 16,)],
                            );
                          },
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseListScreen(
                                  workOutList:
                                      getPage("$title ${type[index]}"),
                                  tag: type[index],
                                  title :"$title ${type[index]}",
                                  stars: 2)),
                        );
                      },
                      subtitle: Container(

                        child: Row(children: [
                          Text(
                            "12 Exercise | ",
                            style: textTheme.bodyText2.copyWith(color: Colors.white)
                          ),

                          Text("25 Minute",style: textTheme.bodyText2.copyWith(color: Colors.white)),
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


