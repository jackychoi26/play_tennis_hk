extension EnumMapper on String {
  T toEnum<T>(String value, List<T> enumValues) {
    for (T enumValue in enumValues) {
      if (enumValue.toString().split('.').last.toLowerCase() ==
          value.toLowerCase().replaceAll('_', '')) {
        return enumValue;
      }
    }

    throw Exception('Invalid value: $value');
  }
}
