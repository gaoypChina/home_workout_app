import 'package:flutter/material.dart';
import '../../../../constants/constant.dart';
import '../../../../helper/sp_helper.dart';
import '../../../../provider/backup_provider.dart';
import '../../../../widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class FourWeekChallengeResetDialog extends StatefulWidget {
  final String spKey;
  final String title;

  const FourWeekChallengeResetDialog(
      {Key? key, required this.spKey, required this.title})
      : super(key: key);

  @override
  State<FourWeekChallengeResetDialog> createState() =>
      _ResetProgressDialogState();
}

class _ResetProgressDialogState extends State<FourWeekChallengeResetDialog> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BackupProvider>(context, listen: false);

    SpHelper spHelper = SpHelper();
    Constants constants = Constants();
    return Opacity(
      opacity: isHidden ? 0 : 1,
      child: AlertDialog(
        title: Text("Reset Progress"),
        content: Text("Reset progress for ${widget.title}"),
        actions: [
          TextButton(
              onPressed: () async {
                setState(() {
                  isHidden = true;
                });
                showDialog(
                    context: context,
                    builder: (builder) => CustomLoadingIndicator(
                          msg: "Processing",
                        ));
                await spHelper.saveInt(widget.spKey, 0);

                await provider.resetUserData();

                constants.getToast("Progress Reset Successfully");

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Yes")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No")),
        ],
      ),
    );
  }
}
