import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_district.dart';
import 'package:play_tennis_hk/domain/extensions/string_to_match_type.dart';
import 'package:play_tennis_hk/domain/match_type.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class TennisMatch {
  final int? id;
  final DateTime? createdAt;
  final UserProfile? poster;
  final num ntrpLevel;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final District district;
  final String court;
  final MatchType matchType;
  final String? remarks;

  TennisMatch({
    this.id,
    this.createdAt,
    this.poster,
    required this.ntrpLevel,
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
      createdAt: DateTime.parse(json['createdAt'] as String),
      poster: UserProfile.fromJson(json['poster']),
      ntrpLevel: json['ntrpLevel'],
      startDateTime: DateTime.parse(json['startDateTime'] as String),
      endDateTime: DateTime.parse(json['endDateTime'] as String),
      district: (json['district'] as String).toDistrict(),
      court: json['court'],
      matchType: (json['matchType'] as String).toMatchType(),
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDateTime': startDateTime.toString(),
      'endDateTime': endDateTime.toString(),
      'matchType': matchType.toKey(),
      'ntrpLevel': ntrpLevel,
      'district': district.toKey(),
      'court': court,
      'remarks': remarks,
    };
  }
}
