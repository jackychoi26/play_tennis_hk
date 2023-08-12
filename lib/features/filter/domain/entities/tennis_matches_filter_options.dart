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
}
