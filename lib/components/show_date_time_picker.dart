import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> sheetDateTimePicker({required context}) async {
  DateTime? pickedTime;

  await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            use24hFormat: true,
            minuteInterval: 60,
            initialDateTime: DateTime.now()
                .add(Duration(minutes: 60 - DateTime.now().minute % 60)),
            onDateTimeChanged: (DateTime newdate) {
              pickedTime = newdate;
            },
          ),
        );
      });

  return pickedTime;
}
