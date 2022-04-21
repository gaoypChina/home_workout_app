import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutCard2by2 extends StatelessWidget {
  final String title;
  const WorkoutCard2by2({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<WorkoutCard2by2Model> _workoutList = [
      WorkoutCard2by2Model(
        title: "Belly fat burner HIIT",
        type: "Beginner",
        imgSrc: "assets/explore_image/img_1.jpg",
        time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_2.jpg",
          time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_3.jpg",
          time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_4.jpg",
          time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_5.jpg",
          time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_6.jpg",
          time: "30 min"
      ),
      WorkoutCard2by2Model(
          title: "Belly fat burner HIIT",
          type: "Beginner",
          imgSrc: "assets/explore_image/img_7.jpg",
          time: "30 min"
      ),
    ];
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,letterSpacing: 1.2),),
      SizedBox(height: 4,),
      Container(

        height: 200,
          color: Colors.white30,
          child: GridView.count(
            physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1/3.3,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children:_workoutList.map((WorkoutCard2by2Model item) {
                return Container(
               //   color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                              child: Image.asset(item.imgSrc,height: 80,fit: BoxFit.fill,)),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(item.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              SizedBox(height: 4,),
                              Row(
                                children: [
                                  Text(item.time),
                                  SizedBox(width: 4,),

                                  Icon(Icons.circle,size: 6,),
                                  SizedBox(width: 4,),
                                  Text(item.type)
                                ],
                              ),
                              Spacer(),
                              Container(height: 1,
                                width: 180,
                                color: Colors.grey.withOpacity(.3),),
                              SizedBox(height: 5,)
                            ],
                          )),

                    ],
                  ),
                );
              }).toList()),
        ),
    ],
  );
  }
}

class WorkoutCard2by2Model {
  final String imgSrc;
  final String title;
  final String time;
  final String type;

  WorkoutCard2by2Model(
      {required this.time,
      required this.title,
      required this.type,
      required this.imgSrc});
}
