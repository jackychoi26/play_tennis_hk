import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';

class DateTimePicker {
  final DateTime? minimumDateTime;
  final DateTime? maximumDateTime;
  final DateTime? initialDateTime;
  final Function(DateTime) onDateTimeChanged;

  DateTimePicker({
    required this.minimumDateTime,
    required this.maximumDateTime,
    required this.initialDateTime,
    required this.onDateTimeChanged,
  });

  Future<void> present({required BuildContext context}) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: minimumDateTime,
                  maximumDate: maximumDateTime,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  minuteInterval: 60,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (DateTime newdate) {
                    onDateTimeChanged(newdate);
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
      },
    );
  }
}
