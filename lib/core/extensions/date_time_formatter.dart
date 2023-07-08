extension DateFormatter on DateTime {
  String getEnglishMonthDayValue() {
    if (month < 1 || month > 12) {
      throw ArgumentError("Invalid month value: $month");
    }

    final monthIndex = month - 1;
    return "$day, ${Month.values[monthIndex].toString().split(".").last}";
  }

  String getChineseMonthDayValue() {
    return "$month月$day日";
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
