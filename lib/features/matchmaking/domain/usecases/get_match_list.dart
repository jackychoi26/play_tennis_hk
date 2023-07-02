import 'package:play_tennis_hk/features/matchmaking/data/repositories/match_repository.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match_list.dart';

class GetMatchList {
  final _repository = MatchDetailRepository();

  Future<MatchList> execute() {
    return _repository.getMatchList();
  }
}
