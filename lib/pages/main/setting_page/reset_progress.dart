import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../helper/sp_helper.dart';
import '../../../helper/sp_key_helper.dart';
import '../../../provider/backup_provider.dart';
import '../../../widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class ResetProgressDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  const ResetProgressDialog(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  State<ResetProgressDialog> createState() => _ResetProgressDialogState();
}

class _ResetProgressDialogState extends State<ResetProgressDialog> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BackupProvider>(context, listen: false);

    SpKey spKey = SpKey();
    SpHelper spHelper = SpHelper();
    Constants constants = Constants();
    return Opacity(
      opacity: isHidden ? 0 : 1,
      child: AlertDialog(
        title: Text("Reset Progress"),
        content: Text(widget.subtitle),
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
                await spHelper.saveInt(spKey.fullBodyChallenge, 0);
                await spHelper.saveInt(spKey.absChallenge, 0);
                await spHelper.saveInt(spKey.armChallenge, 0);
                await spHelper.saveInt(spKey.chestChallenge, 0);
                await provider.resetUserData();

                constants.getToast("Progress Reset Successfully");

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("Yes")),
          TextButton(onPressed: () {}, child: Text("No")),
        ],
      ),
    );
  }
}
