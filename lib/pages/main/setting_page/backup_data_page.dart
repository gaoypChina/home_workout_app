import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/provider/backup_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class BackupDataCard extends StatelessWidget {
  const BackupDataCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double width = MediaQuery.of(context).size.width;
    void registerBottomSheet() async {
      showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          padding: EdgeInsets.symmetric(horizontal: 18),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Material(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Backup & Restore",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        CloseButton()
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Container(
                        width: width - 36,
                        height: 45,
                        child: SignInButton(
                          Buttons.Google,
                          text: "Continue with Google",
                          onPressed: () {
                            final provider = Provider.of<BackupProvider>(
                                context,
                                listen: false);
                            provider.googleLogin(context: context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Container(
                        width: width - 36,
                        height: 45,
                        child: SignInButton(
                          Buttons.Facebook,
                          text: "Continue with Facebook",
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    Text(
                      "Tack Backup of your workout data to analysis your progress and not loos your data in new device.",
                      style: TextStyle(
                          fontSize: 13.5,
                          letterSpacing: 1.2,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.6)),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
    }

    void registeredBottomSheet({ required BackupProvider data}) async {
      showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          padding: EdgeInsets.symmetric(horizontal: 18),
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Material(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Backup & Restore",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        CloseButton()
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Container(
                          width: width - 36,
                          height: 45,
                          child: OutlinedButton(
                            child: Text("Logout"),
                            onPressed: () {
                              final provider = Provider.of<BackupProvider>(
                                  context,
                                  listen: false);
                              provider.logout(context: context);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Container(
                          width: width - 36,
                          height: 45,
                          child: OutlinedButton(
                            child:data.dataSyncing?CircularProgressIndicator() : Text("Sync Data"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              final provider = Provider.of<BackupProvider>(
                                  context,
                                  listen: false);
                              provider.syncData(user:user,context: context);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    Text(
                      "Tack Backup of your workout data to analysis your progress and not loos your data in new device.",
                      style: TextStyle(
                          fontSize: 13.5,
                          letterSpacing: 1.2,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.6)),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });
    }

    return Consumer<BackupProvider>(builder: (_, data, __) {
      user = FirebaseAuth.instance.currentUser;
      return user == null
          ? InkWell(
              onTap: registerBottomSheet,
              child: Container(
                color: Colors.blue.withOpacity(.1),
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        CupertinoIcons.person,
                        color: Colors.white,
                        size: 38,
                      ),
                      radius: 38,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register to sync your data",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.navigate_next_sharp,
                      size: 40,
                    )
                  ],
                ),
              ),
            )
          : InkWell(
              onTap: ()=> registeredBottomSheet(data : data),
              child: Container(
                color: Colors.blue.withOpacity(.1),
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoURL!),
                      backgroundColor: Theme.of(context).primaryColor,
                      //     child: Image.network(user!.photoURL!),
                      radius: 38,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.displayName!,
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        FutureBuilder(
                          future: SpHelper().loadString(SpKey().backupTime),
                          builder: (context,snapshot) {
                            if(snapshot.hasData){
                              String date =DateFormat.yMMMd().format(DateTime.parse(snapshot.data.toString()));
                        String time = DateFormat.jm().format(DateTime.parse(snapshot.data.toString()));
                              return
                                Text(
                                  "Last Sync : $date $time",
                                  style: TextStyle(fontSize: 13.5, letterSpacing:0),
                                );
                            }else{
                              return Container();
                            }

                          }
                        )
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 12,
                    ),
                    data.dataSyncing? CircularProgressIndicator() : Icon(
                     Icons.navigate_next_sharp,
                      size: 40,
                    )
                  ],
                ),
              ),
            );
    });
  }
}
