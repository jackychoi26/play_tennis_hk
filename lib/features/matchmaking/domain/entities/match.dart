class Match {
  final String id;
  final DateTime createdAt;
  final String poster;
  final List<num> ustaLevelRange;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String location;
  final String? remarks;

  Match({
    required this.id,
    required this.createdAt,
    required this.poster,
    required this.ustaLevelRange,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
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
      location: json['location'],
      remarks: json['remarks'],
    );
  }
}
