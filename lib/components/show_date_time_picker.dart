import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

Future<DateTime?> sheetDateTimePicker({required context}) async {
  DateTime? pickedTime =
      DateTime.now().add(Duration(minutes: 60 - DateTime.now().minute % 60));

  await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  minuteInterval: 60,
                  initialDateTime: pickedTime,
                  onDateTimeChanged: (DateTime newdate) {
                    pickedTime = newdate;
                  },
                ),
              ),
              TextButton(
                child: CustomText(AppLocalizations.of(context)?.confirmOk),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      });

  return pickedTime;
}
