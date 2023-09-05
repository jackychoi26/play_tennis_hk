import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DateFormatter on DateTime {
  String _getEnglishMonthDayValue() {
    if (month < 1 || month > 12) {
      throw ArgumentError("Invalid month value: $month");
    }

    final monthIndex = month - 1;
    final monthValue = Month.values[monthIndex].toString().split(".").last;

    final capitalizedFirstLetterMonthValue =
        monthValue[0].toUpperCase() + monthValue.substring(1);

    return "$day, $capitalizedFirstLetterMonthValue";
  }

  String _getChineseMonthDayValue() {
    return "$month月$day日";
  }

  String getLocalizedMonthDayValue(String? localeName) {
    if (localeName == "zh") {
      return _getChineseMonthDayValue();
    } else {
      return _getEnglishMonthDayValue();
    }
  }

  String? getLocalizedDayOfWeekValue(BuildContext context) {
    String dayOfWeek = DateFormat('EEEE').format(this);

    switch (dayOfWeek) {
      case 'Monday':
        return AppLocalizations.of(context)?.monday;
      case 'Tuesday':
        return AppLocalizations.of(context)?.tuesday;
      case 'Wednesday':
        return AppLocalizations.of(context)?.wednesday;
      case 'Thursday':
        return AppLocalizations.of(context)?.thursday;
      case 'Friday':
        return AppLocalizations.of(context)?.friday;
      case 'Saturday':
        return AppLocalizations.of(context)?.saturday;
      case 'Sunday':
        return AppLocalizations.of(context)?.sunday;
      default:
        return null;
    }
  }

  String getHourIn12HoursFormat() {
    if (hour > 12) {
      return "${hour - 12}";
    } else {
      return "$hour";
    }
  }

  bool isPm() {
    return hour > 12;
  }

  String getAmOrPm() {
    return hour >= 12 ? "pm" : "am";
  }
}

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december
}
