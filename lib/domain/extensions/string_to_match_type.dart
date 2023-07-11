import 'package:play_tennis_hk/domain/match_type.dart';

extension MatchTypeParser on String {
  MatchType toMatchType() {
    final camelCaseString = toLowerCase().replaceAll('_', '');
    return MatchType.values.firstWhere((matchType) =>
        matchType.toString().toLowerCase().split('.').last == camelCaseString);
  }
}
