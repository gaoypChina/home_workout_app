
import 'package:full_workout/database/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_plan/full_body_challenge.dart';
class ChallengesModel {
  final String title;
  final String imageUrl;
  final String coverImage;
  final Color color1;
  final String tag;
  final Color color2;
  final List<List<Workout>> challengeList;

  ChallengesModel({
    required this.title,
    required this.tag,
    required this.imageUrl,
    required this.coverImage,
    required this.color1,
    required this.color2,
    required this.challengeList,
  });
}

