import 'package:play_tennis_hk/domain/extensions/string_to_district.dart';
import 'package:play_tennis_hk/domain/district.dart';

class TennisMatchesFilterOptions {
  final num lowerNtrpLevel;
  final num upperNtrpLevel;
  final List<District> selectedDistricts;

  const TennisMatchesFilterOptions({
    required this.lowerNtrpLevel,
    required this.upperNtrpLevel,
    required this.selectedDistricts,
  });

  Map<String, dynamic> toJson() {
    final districts = selectedDistricts.map((e) => e.toString()).toList();

    return {
      "lowerNtrpLevel": lowerNtrpLevel,
      "upperNtrpLevel": upperNtrpLevel,
      "selectedDistricts": districts,
    };
  }

  factory TennisMatchesFilterOptions.fromJson(Map<String, dynamic> json) {
    final districtsList =
        (json['selectedDistricts'] as List<dynamic>).cast<String>();
    final districts = districtsList.map((e) => e.toDistrict()).toList();

    return TennisMatchesFilterOptions(
      lowerNtrpLevel: json["lowerNtrpLevel"],
      upperNtrpLevel: json["upperNtrpLevel"],
      selectedDistricts: districts,
    );
  }
}
