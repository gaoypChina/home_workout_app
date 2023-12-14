import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/backup_provider.dart';
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
                      var backupProvider = Provider.of<BackupProvider>(context,listen: false);
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
                            return DataSyncModal(
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

class DataSyncModal extends StatelessWidget {
  final String userName;
  final Function onSync;

  const DataSyncModal({Key? key, required this.userName, required this.onSync})
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
     SizedBox(height: 24,),
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
                      user?.email ?? "user@mail.com",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(.8),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Container(
                width: size.width - 36,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onSync();
                  },
                  child: Text("Sync Data"),
                )),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                  width: size.width - 36,
                  height: 48,
                  child: OutlinedButton(
                    child: Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.red.shade400.withOpacity(.7),
                          fontWeight: FontWeight.w500),
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        side: BorderSide(
                      color: Colors.red.shade400.withOpacity(.5),
                      width: 1.5,
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Make a backup of your workout data so that you won't lose it if you switch devices. ",
              style: TextStyle(
                  fontSize: 13.5,
                  letterSpacing: 1.0,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(.5)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
