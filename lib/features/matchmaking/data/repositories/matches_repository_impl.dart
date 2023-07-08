import 'package:play_tennis_hk/features/matchmaking/data/webservices/matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match.dart';
// import 'package:play_tennis_hk/features/matchmaking/domain/repositories/matches_repository.dart';

class MatchesRepositoryImpl {
  MatchesRepositoryImpl();

  final matchesWebservice = MatchesWebservice();

  // TODO: find out why cannot override the abstract class
  Future<List<Match>> getMatches() async {
    final matchesResponse = await matchesWebservice.performRequest();
    return matchesResponse.matches;
  }
}
