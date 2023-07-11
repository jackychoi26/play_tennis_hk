import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_match_type.dart';
import 'package:play_tennis_hk/domain/match_type.dart';

class TennisMatch {
  final String id;
  final DateTime createdAt;
  final String poster;
  final List<num> ustaLevelRange;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final District district;
  final String court;
  final MatchType matchType;
  final String? remarks;

  TennisMatch({
    required this.id,
    required this.createdAt,
    required this.poster,
    required this.ustaLevelRange,
    required this.startDateTime,
    required this.endDateTime,
    required this.district,
    required this.court,
    required this.matchType,
    this.remarks,
  });

  @override
  factory TennisMatch.fromJson(Map<String, dynamic> json) {
    return TennisMatch(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt'] as String).toLocal(),
      poster: json['poster'],
      ustaLevelRange: json['ustaLevelRange'].cast<num>(),
      startDateTime: DateTime.parse(json['startDateTime'] as String).toLocal(),
      endDateTime: DateTime.parse(json['endDateTime'] as String).toLocal(),
      district: (json['district'] as String).toDistrict(),
      court: json['court'],
      matchType: (json['matchType'] as String).toMatchType(),
      remarks: json['remarks'],
    );
  }
}
