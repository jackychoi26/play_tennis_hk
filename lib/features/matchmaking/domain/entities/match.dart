class Match {
  final String id;
  final String createdAt;
  final String poster;
  final List<double> ustaLevelRange;
  final String startDateTime;
  final String endDateTime;
  final String location;
  final String? remarks;

  Match(
    this.remarks, {
    required this.id,
    required this.createdAt,
    required this.poster,
    required this.ustaLevelRange,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
  });

  @override
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(json['remark'],
        id: json['id'],
        createdAt: json['createdAt'],
        poster: json['poster'],
        ustaLevelRange: json['ustaLevelRange'].cast<double>(),
        startDateTime: json['startDateTime'],
        endDateTime: json['endDateTime'],
        location: json['location']);
  }
}
