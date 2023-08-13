import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final VoidCallback? onCancel;
  final Future<void> Function()? onConfirm;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: CustomText(title ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: CustomText(AppLocalizations.of(context)?.cancel),
        ),
        TextButton(
          onPressed: () async {
            if (onConfirm != null) {
              await onConfirm!();
            }
          },
          child: CustomText(AppLocalizations.of(context)?.confirmOk),
        ),
      ],
    );
  }
}
