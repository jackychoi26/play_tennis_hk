import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_district.dart';

class Match {
  final String id;
  final DateTime createdAt;
  final String poster;
  final List<num> ustaLevelRange;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final District district;
  final String court;
  final String? remarks;

  Match({
    required this.id,
    required this.createdAt,
    required this.poster,
    required this.ustaLevelRange,
    required this.startDateTime,
    required this.endDateTime,
    required this.district,
    required this.court,
    this.remarks,
  });

  @override
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      poster: json['poster'],
      ustaLevelRange: json['ustaLevelRange'].cast<num>(),
      startDateTime: DateTime.parse(json['startDateTime'] as String).toLocal(),
      endDateTime: DateTime.parse(json['endDateTime'] as String).toLocal(),
      district: (json['district'] as String).toDistrict(),
      court: json['court'],
      remarks: json['remarks'],
    );
  }
}
