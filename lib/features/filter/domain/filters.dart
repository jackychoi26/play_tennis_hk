import 'package:play_tennis_hk/domain/district.dart';

class Filters {
  final List<num> ntrpLevelRange;
  final List<District> selectedDistricts;

  const Filters({
    required this.ntrpLevelRange,
    required this.selectedDistricts,
  });
}
