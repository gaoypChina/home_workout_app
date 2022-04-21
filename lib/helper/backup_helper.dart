import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

const String UserActivityCollection = "user_activity";
const String WorkoutCollection = "workouts";
const String WeightCollection = "weights";
const String UserCollection = "users";

class BackupHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(
      {required String? name,
      required String? dob,
      required int? gender,
      required double? height,
      required double? weight,
      required int? unit,
      required String? email,
      required String uid}) async {
    /// unit: 0->cm/kg, 1->inch/lbs
    /// gender: 0->male, 1->female
    /// height: stored as cm(double)
    /// weight: stored as kg(double)

    try {
      await _db.collection(UserCollection).doc(uid).set({
        "name": name,
        "dob": dob,
        "gender": gender,
        "height": height,
        "weight": weight,
        "unit": unit,
        "email": email
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DocumentSnapshot> getUser({required String uid}) {
    return _db.collection(UserCollection).doc(uid).get();
  }

  Future<void> saveUserActivity({required List workouts,required List weights, required Map<String, dynamic> workoutData, required String uid})async{
    await _db.collection(UserActivityCollection).doc(uid).set({
      "workouts": workouts,
      "weights":weights,
      "workout_data": workoutData
    });
  }

  Future<DocumentSnapshot> getUserActivity({required String uid}) {
    return _db.collection(UserActivityCollection).doc(uid).get();
  }
}
