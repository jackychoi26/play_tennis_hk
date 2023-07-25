import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final VoidCallback? onCancel;
  final Future<void> Function()? onConfirm;
  final IconData? icon;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.onCancel,
    this.onConfirm,
    this.icon = Icons.warning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: CustomText(title ?? ''),
            )
          ],
        ),
      ),
      content: CustomText(content ?? ''),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
