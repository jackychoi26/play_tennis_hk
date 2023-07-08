import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/repositories/tennis_matches_repository.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesRepositoryImpl implements TennisMatchesRepository {
  TennisMatchesRepositoryImpl();

  final matchesWebservice = TennisMatchesWebservice();

  @override
  Future<List<TennisMatch>> getTennisMatches() async {
    final matchesResponse = await matchesWebservice.performRequest();
    return matchesResponse.matches;
  }
}
