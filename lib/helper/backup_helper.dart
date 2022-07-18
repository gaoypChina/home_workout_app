import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

const String UserActivityCollection = "user_activity";
const String WorkoutCollection = "workouts";
const String WeightCollection = "weights";
const String UserCollection = "users";
const String ProUserCollection = "pro_users";

class BackupHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// --------------------------user record ------------------------------
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

  ///----------------------------pro user record --------------------------

  Future<void> saveProUser(
      {required String uid,
      required String firstDate,
      required String lastDate,
      required String? userName,
      required String price}) async {
    await _db.collection(ProUserCollection).doc(uid).set({
      "uid": uid,
      "first_date": firstDate,
      "last_date": lastDate,
      "user_name": userName,
      "price": price
    });
  }

  Future<DocumentSnapshot> getProUser({required String uid}) {
    return _db.collection(ProUserCollection).doc(uid).get();
  }

  ///-----------------------user Activity record-------------------------
  Future<void> saveUserActivity(
      {required List workouts,
      required List weights,
      required Map<String, dynamic> workoutData,
      required String uid}) async {
    await _db.collection(UserActivityCollection).doc(uid).set({
      "workouts": workouts,
      "weights": weights,
      "workout_data": workoutData
    });
  }

  Future<DocumentSnapshot> getUserActivity({required String uid}) {
    return _db.collection(UserActivityCollection).doc(uid).get();
  }

  ///--------------------------Delete user account------------------------

  Future deleteFirebaseDataBase({required String uid}) async {
    await _db.collection(UserActivityCollection).doc(uid).delete();
    await _db.collection(UserCollection).doc(uid).delete();
    await _db.collection(ProUserCollection).doc(uid).delete();
  }

  ///------------------------ Reset user progress ------------------------

  Future resetUserProgress(
      {required String uid, required Map<String, dynamic> workoutData}) async {
    await _db.collection(UserActivityCollection).doc(uid).set({
      "workout_data": workoutData
    });
  }
}
