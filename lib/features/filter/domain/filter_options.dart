import 'package:play_tennis_hk/domain/district.dart';

class FilterOptions {
  final List<num> ntrpLevelRange;
  final List<District> selectedDistricts;

  const FilterOptions({
    required this.ntrpLevelRange,
    required this.selectedDistricts,
  });
}
