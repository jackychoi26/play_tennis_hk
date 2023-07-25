extension DateFormatter on DateTime {
  String _getEnglishMonthDayValue() {
    if (month < 1 || month > 12) {
      throw ArgumentError("Invalid month value: $month");
    }

    final monthIndex = month - 1;
    return "$day, ${Month.values[monthIndex].toString().split(".").last}";
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
