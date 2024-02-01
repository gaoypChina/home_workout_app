import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  UserReview({Key? key}) : super(key: key);

  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  List<UserReviewModel> reviews = [
    UserReviewModel(
        imgSrc: "assets/other/anchit.jpg",
        name: "Anchit Mishra",
        color: Colors.green.withOpacity(.1),
        review:
            "One of the best home workout apps out there would recommend to anyone no matter what their fitness level is as the training can be adjusted to suit them."),
    UserReviewModel(
        imgSrc: "assets/other/max.jpeg",
        name: "Max Bagga",
        color: Colors.green.withOpacity(.1),
        review:
            "Home Workout is a game-changer! The variety of workouts keeps things exciting, and the personalized plans are a perfect fit for my schedule.🌟💪"),
    UserReviewModel(
        imgSrc: "assets/other/nayan.jpg",
        name: "Nayan Lodhi",
        color: Colors.red.withOpacity(.1),
        review:
            "This app is awesome. Instructions are simple clear and well animated for easy understanding. Thank you for this fabulous app."),
    UserReviewModel(
        imgSrc: "assets/other/anshuman.jpg",
        name: "Anshuman Pandey",
        color: Colors.blue.withOpacity(.1),
        review:
            "This is the best workout app I have ever seen. It has plans for different types of exercises depending on what you want to achieve at the end."),
    UserReviewModel(
        imgSrc: "assets/other/avinash.jpg",
        name: "Avinash Shukla",
        color: Colors.orange.withOpacity(.1),
        review:
            "This is an awesome app. Each exercise has been perfectly explained so even a novice can follow it easily. Thanks for putting up efforts in making this app fun-loving.")
  ];

  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    double width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).textTheme.bodyLarge!.color == Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 12),
          child: Row(
            children: [
              Container(
                height: 18,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.blue.shade700),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "What people say about us",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ),
            ],
          ),
        ),
        Container(
          height: 210,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              ...reviews.map((reviewer) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: isDark ? Colors.grey.shade900 : Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: EdgeInsets.only(left: 18),
                  width: width * .7,
                  child: Column(
                    children: [
                      Spacer(),
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(reviewer.imgSrc),
                        //  child: Text(reviewer.name[0]),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        reviewer.review,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                            color: textColor.withOpacity(.8)),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        reviewer.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColor.withOpacity(.7)),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(
                width: 18,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class UserReviewModel {
  final String name;
  final String review;
  final String imgSrc;
  final Color color;

  UserReviewModel(
      {required this.name,
      required this.imgSrc,
      required this.review,
      required this.color});
}
