import 'package:flutter/material.dart';

class UserReview extends StatefulWidget {
  UserReview({Key? key}) : super(key: key);

  @override
  _UserReviewState createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  List<UserReviewModel> reviews = [
    UserReviewModel(
        imgSrc: "assets/other/annchit.jpg",
        name: "Anchit Mishra",
        review:
            "One of the best home workout apps out there would recommend to anyone no matter what their fitness level is as the training can be adjusted to suit them."),
    UserReviewModel(
        imgSrc: "assets/other/nayan.jpg",
        name: "Nayan Lodhi",
        review:
            "This app is awesome. Instructions are simple clear and well animated for easy understanding. Thank you for this fabulous app."),
    UserReviewModel(
        imgSrc: "assets/other/anshman.jpg",
        name: "Anshuman Pandey",
        review:
            "This is the best workout app I have ever seen. It has plans for different types of exercises depending on what you want to achieve at the end."),
    UserReviewModel(
        imgSrc: "assets/other/avinash.jpg",
        name: "Avinash Shukla",
        review:
            "This is an awesome app. Each exercise has been perfectly explained so even a novice can follow it easily. Thanks for putting up efforts in making this app fun-loving.")
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0,bottom: 12),
          child: Text("What People Say About Us",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,letterSpacing: 1.2),),
        ),

        Container(
          height: 210,
          child: ListView(physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              ...reviews.map((reviewer) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.blue.shade50,
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
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,letterSpacing: 1.5),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        reviewer.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              }).toList(),
              SizedBox(width: 18,)
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

  UserReviewModel(
      {required this.name, required this.imgSrc, required this.review});
}
