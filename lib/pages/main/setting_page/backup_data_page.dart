import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/helper/sp_helper.dart';
import 'package:full_workout/helper/sp_key_helper.dart';
import 'package:full_workout/provider/auth_provider.dart';
import 'package:full_workout/provider/backup_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class BackupDataCard extends StatefulWidget {
  const BackupDataCard({Key? key}) : super(key: key);

  @override
  State<BackupDataCard> createState() => _BackupDataCardState();
}

class _BackupDataCardState extends State<BackupDataCard> {
  String lastSync = DateTime.now().toString();
  String userName = "User";

  @override
  void initState() {
    initData();
    super.initState();
  }

  String getParsedTime({required String dateTime}){
    String date = DateFormat.yMMMd().format(DateTime.parse(dateTime));
    String time = DateFormat.jm().format(DateTime.parse(dateTime));
    return "$date $time";
  }

  initData() async {
    SpKey _spKey = SpKey();
    SpHelper _spHelper = SpHelper();

    userName = await _spHelper.loadString(_spKey.name) ?? "User";
     lastSync = await _spHelper.loadString(_spKey.backupTime) ??
        DateTime.now().toIso8601String();



    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    double width = MediaQuery.of(context).size.width;

    void registeredBottomSheet({required BackupProvider data}) async {
      showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: 16,
          padding: EdgeInsets.symmetric(horizontal: 18),
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Material(
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.close),
                            )),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            userName[0].toUpperCase(),
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                          radius: 28,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Image.asset(
                                  "assets/icons/google_icon.png",
                                  height: 20,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              user!.email!,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color!
                                      .withOpacity(.5),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: Container(
                          width: width - 36,
                          height: 45,
                          child: OutlinedButton(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                              color: Colors.red.shade300.withOpacity(.2),
                              width: 1,
                            )),
                            onPressed: () {
                              authProvider.logout(context: context);
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
                            child: data.dataSyncing
                                ? CircularProgressIndicator()
                                : Text(
                                    "Sync Data",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                              color: Colors.blue.shade400.withOpacity(.2),
                              width: 1,
                            )),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await data.syncData(user: user, context: context);
                            },
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Tack Backup of your workout data to analyse your progress and not loos your data on the new device.",
                      style: TextStyle(
                          fontSize: 13.5,
                          letterSpacing: 1.2,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.6)),
                      textAlign: TextAlign.center,
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

    var size = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      height: size.height * .16,
      width: size.width,
      child: Stack(
        children: [
          Opacity(
            opacity: .7,
            child: Image.asset(
              "assets/home_cover/1.jpg",
              fit: BoxFit.fill,
              width: size.width,
              height: size.height * .16,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(.2),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<BackupProvider>(builder: (_, data, __) {
                  user = FirebaseAuth.instance.currentUser;
                  return InkWell(
                    onTap: () => registeredBottomSheet(data: data),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              userName[0].toUpperCase(),
                              style:
                                  TextStyle(fontSize: 32, color: Colors.black),
                            ),
                            radius: 32,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1.2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Last Sync : ${getParsedTime(dateTime: lastSync)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.5,
                                        letterSpacing: -0.1,
                                        fontWeight:
                                        FontWeight.w500),
                                  ),
                                ),
                              ],
                            )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.sync,
                            color: Colors.white.withOpacity(.7),
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
