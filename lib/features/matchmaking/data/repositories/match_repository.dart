import 'package:play_tennis_hk/features/matchmaking/data/webservices/match_list_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match_list.dart';

class MatchDetailRepository {
  final matchListWebservice = MatchListWebservice();

  Future<MatchList> getMatchList() {
    return matchListWebservice.performRequest();
  }
}
