import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/provider/auth_provider.dart';
import 'package:full_workout/provider/backup_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../enums/app_conection_status.dart';

class BackupDataCard extends StatelessWidget {
  final String lastSync;
  final String name;
  final Function onSync;

  const BackupDataCard({
    Key? key,
    required this.lastSync,
    required this.name,
    required this.onSync,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var backupProvider = Provider.of<BackupProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    String getParsedTime({required String dateTime}) {
      String date = DateFormat.yMMMd().format(DateTime.parse(dateTime));
      String time = DateFormat.jm().format(DateTime.parse(dateTime));
      return "$date $time";
    }

    return Container(
      color: Colors.black,
      width: size.width,
      child: Stack(
        children: [
          Opacity(
            opacity: .3,
            child: Image.asset(
              // 1 6 7
              "assets/home_cover/11.jpg",
              fit: BoxFit.fill,
              width: size.width,
              height: size.height * .16 + 70,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(
                  flex: 4,
                ),
                InkWell(
                    onTap: () async {
                      bool isDisabled = backupProvider.connectionStatus ==
                              AppConnectionStatus.loading ||
                          authProvider.connectionStatus ==
                              AppConnectionStatus.loading;

                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18))),
                          enableDrag: !isDisabled,
                          isDismissible: !isDisabled,
                          context: context,
                          builder: (context) {
                            return _DataSyncModal(
                              userName: name,
                              onSync: onSync,
                            );
                          });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              name[0].toUpperCase(),
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
                                  name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1.2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Last Sync : ${getParsedTime(dateTime: lastSync)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.5,
                                      letterSpacing: -0.1,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.sync,
                                color: Colors.white.withOpacity(.9),
                                size: 30,
                              ),
                              onPressed: () {
                                onSync();
                              }),
                        ],
                      ),
                    )),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSyncModal extends StatelessWidget {
  final String userName;
  final Function onSync;

  const _DataSyncModal({Key? key, required this.userName, required this.onSync})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      children: [
                        Text(
                          userName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      user?.email ?? "user@domail.com",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .color!
                              .withOpacity(.7),
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
                  width: size.width - 36,
                  height: 45,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(.6),
                      width: 1.5,
                    )),
                    child: Text("Sync Data",
                        style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.8),
                            fontWeight: FontWeight.w500)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSync();
                    },
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Consumer<AuthProvider>(builder: (context, authProvider, _) {
              return Center(
                child: Container(
                    width: size.width - 36,
                    height: 45,
                    child: OutlinedButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.red.shade400.withOpacity(.7),
                            fontWeight: FontWeight.w500),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        color: Colors.red.shade400.withOpacity(.5),
                        width: 1.5,
                      )),
                      onPressed: () {
                        authProvider.logout(context: context);
                      },
                    )),
              );
            }),
            SizedBox(
              height: 12,
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
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
