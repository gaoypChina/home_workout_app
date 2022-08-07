import '../../database/workout_list.dart';

class ChallengesModel {
  final String title;
  final String imageUrl;
  final String coverImage;
  final String tag;
  final List<List<Workout>> challengeList;

  ChallengesModel({
    required this.title,
    required this.tag,
    required this.imageUrl,
    required this.coverImage,
    required this.challengeList,
  });
}
