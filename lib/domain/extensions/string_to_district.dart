import 'package:play_tennis_hk/domain/district.dart';

extension DistrictParser on String {
  District toDistrict() {
    final camelCaseString = toLowerCase().replaceAll('_', '');
    return District.values.firstWhere((districts) =>
        districts.toString().toLowerCase().split('.').last == camelCaseString);
  }
}
