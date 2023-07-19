import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/repositories/tennis_matches_repository.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchesRepositoryImpl implements TennisMatchesRepository {
  TennisMatchesRepositoryImpl();

  final tennisMatchesWebservice = TennisMatchesWebservice();

  @override
  Future<List<TennisMatch>> getTennisMatches() async {
    final tennisMatchesResponse =
        await tennisMatchesWebservice.performRequest();
    return tennisMatchesResponse.tennisMatches;
  }
}
