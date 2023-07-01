class Match {
  final String id;
  final DateTime createdAt;
  final String poster;
  final List<double> ustaLevelRange;
  final DateTime gameStartTime;
  final DateTime gameEndTime;
  final String location;
  final String? remarks;

  Match(
    this.remarks, {
    required this.id,
    required this.createdAt,
    required this.poster,
    required this.ustaLevelRange,
    required this.gameStartTime,
    required this.gameEndTime,
    required this.location,
  });
}
