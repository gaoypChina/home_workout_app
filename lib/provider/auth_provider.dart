import 'dart:developer' as dev;
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../provider/backup_provider.dart';
import '../../../provider/subscription_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant.dart';
import '../enums/app_conection_status.dart';
import '../helper/backup_helper.dart';
import '../helper/recent_workout_db_helper.dart';
import '../helper/sp_helper.dart';
import '../helper/weight_db_helper.dart';
import '../pages/detail_input_page/detail_input_page.dart';
import '../pages/main_page.dart';
import '../widgets/dialogs/delete_account_fail_dialog.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  BackupHelper _dbHelper = BackupHelper();
  Constants _constants = Constants();
  AppConnectionStatus connectionStatus = AppConnectionStatus.none;

  bool dataSyncing = false;
  bool authLoading = false;

  navigateToNextPage({required BuildContext context}) async {
    try {
      var subscriptionProvider =
          Provider.of<SubscriptionProvider>(context, listen: false);
      await subscriptionProvider.setSubscriptionDetails();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool userExist = await isUserExist(context: context, user: user);
        if (userExist) {
          // sync data
          var backupProvider =
              Provider.of<BackupProvider>(context, listen: false);
          await backupProvider.syncData(
              context: context, isLoginPage: true, showMsg: false);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MainPage(index: 0);
          }));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailInputPage();
          }));
        }
      }
    } catch (e) {
      throw "error while checking user exist or not";
    }
  }

  Future googleLogin({required BuildContext context}) async {
    connectionStatus = AppConnectionStatus.loading;
    notifyListeners();
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw ("google login error : google user is null");
      }
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      await navigateToNextPage(context: context);
      await SpHelper().saveBool(SpKey().authByGoogle, true);
      _constants.getToast("User Login Successfully");
    } catch (e) {
      log("error while login with google: $e");
      _constants.getToast("Something went wrong");
    } finally {
      connectionStatus = AppConnectionStatus.success;
      notifyListeners();
    }
  }

  Future emailLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    connectionStatus = AppConnectionStatus.loading;
    notifyListeners();
    log("message");
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        throw "user not login properly";
      }
      await navigateToNextPage(context: context);
      await SpHelper().saveBool(SpKey().authByGoogle, false);
      _constants.getToast("User Login Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _constants.getToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _constants.getToast('Wrong password provided for that user.');
      }
    } catch (e) {
      _constants.getToast('something went wrong');
      log(e.toString());
    } finally {
      connectionStatus = AppConnectionStatus.success;
      notifyListeners();
    }
  }

  Future emailSignup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    connectionStatus = AppConnectionStatus.loading;
    notifyListeners();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await navigateToNextPage(context: context);
      await SpHelper().saveBool(SpKey().authByGoogle, false);
      _constants.getToast("User Login Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _constants.getToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _constants.getToast('The account already exists for that email.');
      }
    } catch (e) {
      _constants.getToast('something went wrong');
      log(e.toString());
    } finally {
      connectionStatus = AppConnectionStatus.success;
      notifyListeners();
    }
  }

  Future resetEmailPassword(
      {required String email, required BuildContext context}) async {
    connectionStatus = AppConnectionStatus.loading;
    notifyListeners();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.of(context).pop();
      _constants.getSnackBar(
          context: context, msg: "Password Reset Email Sent");
    } catch (e) {
      _constants.getSnackBar(context: context, msg: "Something went wrong");
    } finally {
      connectionStatus = AppConnectionStatus.success;
      notifyListeners();
    }
  }

  Future<bool> isUserExist(
      {required BuildContext context, required User user}) async {
    try {
      var _snapshot = await _dbHelper.getUser(uid: user.uid);
      Map<String, dynamic>? _userData =
          _snapshot.data() as Map<String, dynamic>?;
      if (_userData == null) {
        return false;
      }
      if (_userData["name"] == null ||
          _userData["dob"] == null ||
          _userData["gender"] == null ||
          _userData["height"] == null ||
          _userData["weight"] == null) {
        log(_userData.toString());
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future facebookLogin({required BuildContext context}) async {
    try {
      authLoading = true;
      notifyListeners();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null &&
          loginResult.accessToken?.token != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      } else {
        throw ("facebook login error : facebook user in null \nline 86 authProvider");
      }

      _constants.getToast("User Login Successfully");
      Navigator.of(context).pop();
    } catch (e) {
      dev.log(e.toString());
      _constants.getToast("Something went wrong");
    } finally {
      authLoading = false;
      notifyListeners();
    }
  }

  Future logout({required BuildContext context}) async {
    authLoading = true;
    notifyListeners();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw "user not found";
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      RecentDatabaseHelper recentDatabaseHelper = RecentDatabaseHelper();
      WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();

      // sync user data
      var backupProvider = Provider.of<BackupProvider>(context, listen: false);
      await backupProvider.saveData(user: user);

      // logout user
      bool isAuthByGoogle =
          await SpHelper().loadBool(SpKey().authByGoogle) ?? false;
      FirebaseAuth.instance.signOut();

      if (isAuthByGoogle) {
        await googleSignIn.disconnect();
      }

      await recentDatabaseHelper.deleteDataBase();
      await weightDatabaseHelper.deleteDataBase();
      await preferences.clear();

      _constants.getToast("User Logout Successfully");
      Phoenix.rebirth(context);
    } catch (e) {
      _constants.getToast("Something went wrong");
      log("error : ${e.toString()}");
    } finally {
      authLoading = false;
      notifyListeners();
    }
  }

  Future deleteAccount({required BuildContext context}) async {
    authLoading = true;
    notifyListeners();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw "user not found";
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      RecentDatabaseHelper recentDatabaseHelper = RecentDatabaseHelper();
      WeightDatabaseHelper weightDatabaseHelper = WeightDatabaseHelper();

      // sync user data
      var backupProvider = Provider.of<BackupProvider>(context, listen: false);
      await backupProvider.saveData(user: user);

      // logout user
      await _dbHelper.deleteFirebaseDataBase(uid: user.uid);
      bool isAuthByGoogle =
          await SpHelper().loadBool(SpKey().authByGoogle) ?? false;
      FirebaseAuth.instance.signOut();
      if (isAuthByGoogle) {
        await googleSignIn.disconnect();
      }

      // delete user local data
      await recentDatabaseHelper.deleteDataBase();
      await weightDatabaseHelper.deleteDataBase();
      await preferences.clear();
      _constants.getToast("User Data Deleted Successfully");
      Phoenix.rebirth(context);
    } catch (e) {
      showDialog(
          context: context, builder: (builder) => DeleteAccountFailDialog());
      log("error : ${e.toString()}");
    } finally {
      authLoading = false;
      notifyListeners();
    }
  }
}
